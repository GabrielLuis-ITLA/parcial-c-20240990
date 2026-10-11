#include "fsl_device_registers.h"
#include "fsl_debug_console.h"
#include "board.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "fsl_gpio.h"
#include "fsl_port.h"
#include "fsl_ctimer.h"
#include "fsl_lpuart.h"
#include "fsl_reset.h"
#include <string.h>

/* ================= GLOBALS & DEFINES ================= */
#define APP_TICK_TIMER CTIMER0
#define APP_TICK_IRQn  CTIMER0_IRQn
#define APP_PWM_TIMER CTIMER1
#define APP_PWM_PERIOD_CH 3
#define APP_PWM_CHANNEL 2
#define APP_SW2_GPIO GPIO1
#define APP_SW2_PIN 7U
#define APP_SW2_IRQ GPIO1_IRQn

/* LED Verde de Estado */
#ifndef BOARD_LED_GREEN_GPIO
#define APP_LED_GPIO GPIO3
#define APP_LED_PIN 13U
#define APP_LED_ON 0U
#define APP_LED_OFF 1U
#else
#define APP_LED_GPIO BOARD_LED_GREEN_GPIO
#define APP_LED_PIN BOARD_LED_GREEN_GPIO_PIN
#define APP_LED_ON LOGIC_LED_ON
#define APP_LED_OFF LOGIC_LED_OFF
#endif

#if defined(BOARD_DEBUG_UART_BASEADDR)
    #define APP_UART ((LPUART_Type *)BOARD_DEBUG_UART_BASEADDR)
#else
    #define APP_UART LPUART0
#endif

typedef enum { STATE_MANUAL, STATE_AUTO, STATE_PAUSE } app_state_t;
app_state_t currentState = STATE_MANUAL;
app_state_t prevState = STATE_MANUAL;

uint8_t currentDuty = 25U;
uint8_t savedManualDuty = 25U;
uint8_t autoDirection = 1U;
uint8_t streamOn = 0U;
uint32_t currentFreq = 1000U;

volatile uint32_t g_ms = 0;
volatile uint32_t g_buttonEdgePending = 0U;
uint32_t errorCount = 0U; 

/* ================= RING BUFFER UART ================= */
#define RX_RING_BUFFER_SIZE 128U
#define CMD_BUFFER_SIZE 64U
volatile uint8_t rxRingBuffer[RX_RING_BUFFER_SIZE];
volatile uint16_t rxHead = 0;
volatile uint16_t rxTail = 0;

/* ================= HW INITIALIZATION ================= */
void Demo_TickCallback(uint32_t flags)
{
    if (flags & kCTIMER_Match0Flag) { ++g_ms; }
}
static ctimer_callback_t tickCallbacks[] = {Demo_TickCallback};

void Demo_TickInit(void)
{
    ctimer_config_t cfg;
    ctimer_match_config_t match = {0};
    CTIMER_GetDefaultConfig(&cfg);
    cfg.prescale = 0U; 
    CTIMER_Init(APP_TICK_TIMER, &cfg);
    
    match.matchValue = 12000000U / 1000U - 1U;
    match.enableCounterReset = true;
    match.enableCounterStop = false;
    match.outControl = kCTIMER_Output_NoAction;
    match.outPinInitState = false;
    match.enableInterrupt = true;
    CTIMER_RegisterCallBack(APP_TICK_TIMER, tickCallbacks, kCTIMER_SingleCallback);
    CTIMER_SetupMatch(APP_TICK_TIMER, kCTIMER_Match_0, &match);
    EnableIRQ(APP_TICK_IRQn);
    CTIMER_StartTimer(APP_TICK_TIMER);
}

/* HACK: MANIPULACIÓN DIRECTA DE LOS REGISTROS PWM PARA EVITAR ERRORES DEL SDK */
void Demo_PwmInit(void)
{
    CLOCK_SetClockDiv(kCLOCK_DivCTIMER1, 1U);
    CLOCK_AttachClk(kFRO12M_to_CTIMER1);
    RESET_ReleasePeripheralReset(kCTIMER1_RST_SHIFT_RSTn);
    CLOCK_EnableClock(kCLOCK_GateCTIMER1);
    
    APP_PWM_TIMER->TCR = 0; /* Detener temporizador */
    APP_PWM_TIMER->PR = 0;  /* Sin prescaler (reloj a 12 MHz) */
    
    /* Registro de periodo (Match 3) a 1000 Hz */
    APP_PWM_TIMER->MR[APP_PWM_PERIOD_CH] = 12000U;
    
    /* MCR: Resetear el contador al llegar al Match 3 */
    APP_PWM_TIMER->MCR = (1U << 10);
    
    /* PWMC: Habilitar modo PWM en Match 2 (P3_12) */
    APP_PWM_TIMER->PWMC = (1U << APP_PWM_CHANNEL);
    
    APP_PWM_TIMER->TCR = 1; /* Iniciar temporizador */
}

void Demo_SetPwmDuty(uint8_t duty)
{
    if (duty > 100U) duty = 100U;
    uint32_t period = APP_PWM_TIMER->MR[APP_PWM_PERIOD_CH];
    
    if (duty == 0U) {
        APP_PWM_TIMER->MR[APP_PWM_CHANNEL] = period + 1U; /* Nunca llega al Match, se queda en 0V absoluto */
    }
    else if (duty == 100U) {
        APP_PWM_TIMER->MR[APP_PWM_CHANNEL] = 0U; /* Salta a 3.3V al instante, sin pulsos residuales */
    }
    else {
        uint32_t ticks = (period * duty) / 100U;
        APP_PWM_TIMER->MR[APP_PWM_CHANNEL] = period - ticks;
    }
}

void GPIO1_IRQHandler(void)
{
    uint32_t flags = GPIO_PortGetInterruptFlags(APP_SW2_GPIO);
    GPIO_PortClearInterruptFlags(APP_SW2_GPIO, flags);
    if (flags & (1U << APP_SW2_PIN)) { g_buttonEdgePending = 1U; }
    SDK_ISR_EXIT_BARRIER;
}

void Demo_ButtonInit(void)
{
    gpio_pin_config_t sw_config = {kGPIO_DigitalInput, 0};
    GPIO_PinInit(APP_SW2_GPIO, APP_SW2_PIN, &sw_config);
    GPIO_SetPinInterruptConfig(APP_SW2_GPIO, APP_SW2_PIN, kGPIO_InterruptEitherEdge);
    EnableIRQ(APP_SW2_IRQ);
}

void Demo_StatusLedInit(void)
{
    gpio_pin_config_t led_config = {kGPIO_DigitalOutput, APP_LED_ON};
    GPIO_PinInit(APP_LED_GPIO, APP_LED_PIN, &led_config);
}

/* ================= PARSER HELPERS ================= */
bool Demo_TryReadByte(uint8_t *byte)
{
    uint32_t flags = LPUART_GetStatusFlags(APP_UART);
    if (flags & (kLPUART_RxOverrunFlag | kLPUART_NoiseErrorFlag | kLPUART_FramingErrorFlag)) {
        LPUART_ClearStatusFlags(APP_UART, kLPUART_RxOverrunFlag | kLPUART_NoiseErrorFlag | kLPUART_FramingErrorFlag);
    }
    if ((flags & kLPUART_RxDataRegFullFlag) == 0U) { return false; }
    *byte = LPUART_ReadByte(APP_UART);
    return true;
}

int ParseStrictInt(const char* str, int* outVal)
{
    if (*str == '\0') return 0;
    int val = 0;
    while (*str) {
        if (*str < '0' || *str > '9') return 0;
        val = val * 10 + (*str - '0');
        str++;
    }
    *outVal = val;
    return 1;
}

char* Trim(char* str)
{
    while(*str == ' ' || *str == '\r' || *str == '\n') str++;
    if (*str == 0) return str;
    char* end = str + strlen(str) - 1;
    while(end > str && (*end == ' ' || *end == '\r' || *end == '\n')) {
        *end = '\0';
        end--;
    }
    return str;
}

void ProcessCommand(char* cmdRaw)
{
    char* cmd = Trim(cmdRaw);
    if (strlen(cmd) == 0) return;

    if (currentState == STATE_PAUSE) {
        if (strncmp(cmd, "MODE", 4) == 0 || strncmp(cmd, "DUTY", 4) == 0 || strncmp(cmd, "FREQ", 4) == 0) {
            errorCount++;
            PRINTF("ERR STATE\r\n");
            return;
        }
    }

    if (strcmp(cmd, "HELP") == 0) {
        PRINTF("Comandos: HELP, STATUS, MODE MANUAL, MODE AUTO, DUTY n, FREQ n, PAUSE, RESUME, STREAM ON, STREAM OFF\r\nOK\r\n");
    }
    else if (strcmp(cmd, "STATUS") == 0) {
        PRINTF("Modo: %d, Freq: %dHz, Duty: %d%%, ManDuty: %d%%, Uptime: %ds, Errores: %d\r\nOK\r\n", 
                currentState, currentFreq, currentDuty, savedManualDuty, (g_ms/1000), errorCount);
    }
    else if (strcmp(cmd, "MODE MANUAL") == 0) {
        currentState = STATE_MANUAL;
        currentDuty = savedManualDuty;
        Demo_SetPwmDuty(currentDuty);
        PRINTF("OK\r\n");
    }
    else if (strcmp(cmd, "MODE AUTO") == 0) {
        currentState = STATE_AUTO;
        currentDuty = 10U;
        autoDirection = 1U;
        Demo_SetPwmDuty(currentDuty);
        PRINTF("OK\r\n");
    }
    else if (strncmp(cmd, "DUTY", 4) == 0) {
        if (currentState == STATE_AUTO) { 
            errorCount++;
            PRINTF("ERR STATE\r\n"); 
        }
        else {
            char* arg = Trim(cmd + 4);
            int val;
            if (ParseStrictInt(arg, &val)) {
                if (val >= 0 && val <= 100) {
                    savedManualDuty = (uint8_t)val;
                    if (currentState == STATE_MANUAL) {
                        currentDuty = savedManualDuty;
                        Demo_SetPwmDuty(currentDuty);
                    }
                    PRINTF("OK\r\n");
                } else { errorCount++; PRINTF("ERR RANGE\r\n"); }
            } else { errorCount++; PRINTF("ERR ARG\r\n"); }
        }
    }
    else if (strncmp(cmd, "FREQ", 4) == 0) {
        char* arg = Trim(cmd + 4);
        int val;
        if (ParseStrictInt(arg, &val)) {
            if (val == 500 || val == 1000 || val == 2000) {
                currentFreq = (uint32_t)val;
                uint32_t ticks = 12000000U / currentFreq;
                APP_PWM_TIMER->MR[APP_PWM_PERIOD_CH] = ticks; 
                Demo_SetPwmDuty(currentDuty);
                PRINTF("OK\r\n");
            } else { errorCount++; PRINTF("ERR RANGE\r\n"); }
        } else { errorCount++; PRINTF("ERR ARG\r\n"); }
    }
    else if (strcmp(cmd, "PAUSE") == 0) {
        if (currentState == STATE_PAUSE) { PRINTF("OK\r\n"); }
        else {
            prevState = currentState;
            currentState = STATE_PAUSE;
            Demo_SetPwmDuty(0U);
            PRINTF("OK\r\n");
        }
    }
    else if (strcmp(cmd, "RESUME") == 0) {
        if (currentState != STATE_PAUSE) { errorCount++; PRINTF("ERR STATE\r\n"); }
        else {
            currentState = prevState;
            Demo_SetPwmDuty(currentDuty);
            PRINTF("OK\r\n");
        }
    }
    else if (strcmp(cmd, "STREAM ON") == 0) {
        streamOn = 1U;
        PRINTF("OK\r\n");
    }
    else if (strcmp(cmd, "STREAM OFF") == 0) {
        streamOn = 0U;
        PRINTF("OK\r\n");
    }
    else {
        errorCount++;
        PRINTF("ERR COMMAND\r\n");
    }
}

/* ================= MAIN ================= */
int main(void)
{
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitDebugConsole();

    CLOCK_SetClockDiv(kCLOCK_DivCTIMER0, 1U);
    CLOCK_AttachClk(kFRO12M_to_CTIMER0);
    RESET_ReleasePeripheralReset(kCTIMER0_RST_SHIFT_RSTn);
    CLOCK_EnableClock(kCLOCK_GateCTIMER0);
    
    Demo_TickInit();
    Demo_PwmInit();
    Demo_ButtonInit();
    Demo_StatusLedInit(); 

    PRINTF("FRDM-MCXA156: consola disponible\r\n");

    uint32_t lastService = g_ms;
    uint32_t debounceCounter = 0U;
    uint8_t isDebouncing = 0U;
    uint8_t targetEdge = 0U;
    uint8_t buttonActive = 0U;
    uint32_t pressDuration = 0U;
    
    uint8_t shortPressFlag = 0U;
    uint8_t longPressFlag = 0U;
    uint32_t autoTimer = 0U;
    uint32_t streamTimer = 0U;
    uint32_t statusLedTimer = 0U; 
    
    char cmdBuffer[CMD_BUFFER_SIZE];
    uint8_t cmdIdx = 0U;
    uint8_t overflowState = 0U;
    uint8_t rxChar;

    Demo_SetPwmDuty(currentDuty);
    GPIO_PinWrite(APP_LED_GPIO, APP_LED_PIN, APP_LED_ON); 

    for (;;)
    {
        uint32_t now = g_ms;
        
        while (Demo_TryReadByte(&rxChar))
        {
            uint16_t nextHead = (rxHead + 1) % RX_RING_BUFFER_SIZE;
            if (nextHead != rxTail) {
                rxRingBuffer[rxHead] = rxChar;
                rxHead = nextHead;
            }
        }
        
        while (rxTail != rxHead)
        {
            uint8_t c = rxRingBuffer[rxTail];
            rxTail = (rxTail + 1) % RX_RING_BUFFER_SIZE;
            
            if (c == '\n' || c == '\r') {
                if (cmdIdx > 0) {
                    cmdBuffer[cmdIdx] = '\0';
                    if (!overflowState) { ProcessCommand(cmdBuffer); }
                    else { errorCount++; PRINTF("ERR OVERFLOW\r\n"); overflowState = 0U; }
                    cmdIdx = 0U;
                } else if (overflowState) {
                    errorCount++; PRINTF("ERR OVERFLOW\r\n"); 
                    overflowState = 0U;
                }
            } else {
                if (cmdIdx < CMD_BUFFER_SIZE - 1) { cmdBuffer[cmdIdx++] = (char)c; }
                else { overflowState = 1U; }
            }
        }
        
        if (g_buttonEdgePending)
        {
            g_buttonEdgePending = 0U;
            if (!isDebouncing) {
                isDebouncing = 1U;
                debounceCounter = 0U;
                targetEdge = GPIO_PinRead(APP_SW2_GPIO, APP_SW2_PIN);
            }
        }
        
        if ((uint32_t)(now - lastService) >= 1U)
        {
            lastService = now;
            
            if (isDebouncing) {
                debounceCounter++;
                if (debounceCounter >= 30U) {
                    isDebouncing = 0U;
                    if (GPIO_PinRead(APP_SW2_GPIO, APP_SW2_PIN) == targetEdge) {
                        if (targetEdge == 0U) {
                            buttonActive = 1U;
                            pressDuration = 0U;
                        } else {
                            if (buttonActive) {
                                buttonActive = 0U;
                                if (pressDuration >= 30U && pressDuration < 1500U) { shortPressFlag = 1U; }
                            }
                        }
                    }
                }
            }

            if (buttonActive && !isDebouncing) {
                pressDuration++;
                if (pressDuration == 1500U) { longPressFlag = 1U; }
            }

            if (shortPressFlag) {
                shortPressFlag = 0U;
                if (currentState == STATE_MANUAL) {
                    currentState = STATE_AUTO;
                    currentDuty = 10U;
                    autoDirection = 1U;
                    autoTimer = 0U;
                    Demo_SetPwmDuty(currentDuty);
                    PRINTF("Modo: AUTO\r\n");
                }
                else if (currentState == STATE_AUTO) {
                    currentState = STATE_MANUAL;
                    currentDuty = savedManualDuty;
                    Demo_SetPwmDuty(currentDuty);
                    GPIO_PinWrite(APP_LED_GPIO, APP_LED_PIN, APP_LED_ON); 
                    PRINTF("Modo: MANUAL\r\n");
                }
            }

            if (longPressFlag) {
                longPressFlag = 0U;
                if (currentState != STATE_PAUSE) {
                    prevState = currentState;
                    currentState = STATE_PAUSE;
                    Demo_SetPwmDuty(0U);
                    PRINTF("Modo: PAUSA\r\n");
                } else {
                    currentState = prevState;
                    Demo_SetPwmDuty(currentDuty);
                    if (currentState == STATE_MANUAL) {
                        GPIO_PinWrite(APP_LED_GPIO, APP_LED_PIN, APP_LED_ON);
                    }
                    PRINTF("Modo: RESUME\r\n");
                }
            }

            if (currentState == STATE_AUTO) {
                autoTimer++;
                if (autoTimer >= 20U) {
                    autoTimer = 0U;
                    if (autoDirection == 1U) {
                        currentDuty++;
                        if (currentDuty >= 90U) { autoDirection = 0U; }
                    } else {
                        currentDuty--;
                        if (currentDuty <= 10U) { autoDirection = 1U; }
                    }
                    Demo_SetPwmDuty(currentDuty);
                }
            }

            statusLedTimer++;
            if (currentState == STATE_AUTO) {
                if (statusLedTimer >= 500U) {
                    statusLedTimer = 0U;
                    GPIO_PortToggle(APP_LED_GPIO, 1U << APP_LED_PIN);
                }
            } else if (currentState == STATE_PAUSE) {
                if (statusLedTimer >= 125U) {
                    statusLedTimer = 0U;
                    GPIO_PortToggle(APP_LED_GPIO, 1U << APP_LED_PIN);
                }
            } else {
                statusLedTimer = 0U; 
            }
            
            streamTimer++;
            if (streamTimer >= 1000U) {
                streamTimer = 0U;
                if (streamOn) {
                    PRINTF("TELEMETRIA: Modo=%d, Freq=%dHz, Duty=%d%%\r\n", currentState, currentFreq, currentDuty);
                }
            }
        }
    }
    return 0;
}