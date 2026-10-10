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

#define APP_TICK_TIMER CTIMER0
#define APP_TICK_IRQn  CTIMER0_IRQn

volatile uint32_t g_ms = 0;
volatile uint32_t g_buttonEdgePending = 0U;

void Demo_TickCallback(uint32_t flags)
{
    if (flags & kCTIMER_Match0Flag)
    {
        ++g_ms;
    }
}

static ctimer_callback_t tickCallbacks[] = {Demo_TickCallback};

void Demo_TickInit(uint32_t timerClockHz)
{
    ctimer_config_t cfg;
    ctimer_match_config_t match = {0};

    CTIMER_GetDefaultConfig(&cfg);
    cfg.prescale = 0U;
    CTIMER_Init(APP_TICK_TIMER, &cfg);

    match.matchValue = timerClockHz / 1000U - 1U;
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

#define APP_PWM_TIMER CTIMER1
#define APP_PWM_PERIOD_CH kCTIMER_Match_3
#define APP_PWM_CHANNEL kCTIMER_Match_2

void Demo_PwmInit(void)
{
    ctimer_config_t cfg;
    
    CLOCK_SetClockDiv(kCLOCK_DivCTIMER1, 1U);
    CLOCK_AttachClk(kFRO12M_to_CTIMER1);
    RESET_ReleasePeripheralReset(kCTIMER1_RST_SHIFT_RSTn);
    CLOCK_EnableClock(kCLOCK_GateCTIMER1);

    CTIMER_GetDefaultConfig(&cfg);
    CTIMER_Init(APP_PWM_TIMER, &cfg);

    CTIMER_SetupPwmPeriod(APP_PWM_TIMER, APP_PWM_CHANNEL, APP_PWM_PERIOD_CH, 12000U, 0U, false);
    CTIMER_StartTimer(APP_PWM_TIMER);
}

void Demo_SetPwmDuty(uint8_t duty)
{
    if (duty > 100U) 
    {
        duty = 100U;
    }
    CTIMER_UpdatePwmDutycycle(APP_PWM_TIMER, APP_PWM_CHANNEL, APP_PWM_PERIOD_CH, duty);
}

#define APP_SW2_GPIO GPIO1
#define APP_SW2_PIN 7U
#define APP_SW2_IRQ GPIO1_IRQn

void GPIO1_IRQHandler(void)
{
    uint32_t flags = GPIO_PortGetInterruptFlags(APP_SW2_GPIO);
    GPIO_PortClearInterruptFlags(APP_SW2_GPIO, flags);
    
    if (flags & (1U << APP_SW2_PIN))
    {
        g_buttonEdgePending = 1U;
    }
    SDK_ISR_EXIT_BARRIER;
}

void Demo_ButtonInit(void)
{
    gpio_pin_config_t sw_config = {kGPIO_DigitalInput, 0};
    
    GPIO_PinInit(APP_SW2_GPIO, APP_SW2_PIN, &sw_config);
    GPIO_SetPinInterruptConfig(APP_SW2_GPIO, APP_SW2_PIN, kGPIO_InterruptFallingEdge);
    
    EnableIRQ(APP_SW2_IRQ);
}

int main(void)
{
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitDebugConsole();

    PRINTF("FRDM-MCXA156: consola disponible\r\n");

    CLOCK_SetClockDiv(kCLOCK_DivCTIMER0, 1U);
    CLOCK_AttachClk(kFRO12M_to_CTIMER0);
    RESET_ReleasePeripheralReset(kCTIMER0_RST_SHIFT_RSTn);
    CLOCK_EnableClock(kCLOCK_GateCTIMER0);
    
    Demo_TickInit(12000000U);
    Demo_PwmInit();
    Demo_ButtonInit();

    uint32_t lastService = g_ms;
    uint32_t testCounter = 0;
    uint8_t testDuty = 10U; 
    
    uint32_t debounceCounter = 0;
    uint8_t isDebouncing = 0;
    
    for (;;)
    {
        uint32_t now = g_ms;
        
        if (g_buttonEdgePending)
        {
            g_buttonEdgePending = 0U;
            if (!isDebouncing)
            {
                isDebouncing = 1;
                debounceCounter = 0;
            }
        }
        
        if ((uint32_t)(now - lastService) >= 1U)
        {
            lastService = now;
            
            if (isDebouncing)
            {
                debounceCounter++;
                if (debounceCounter >= 30U)
                {
                    isDebouncing = 0;
                    if (GPIO_PinRead(APP_SW2_GPIO, APP_SW2_PIN) == 0U)
                    {
                        PRINTF("Boton presionado correctamente (antirrebote 30ms)\r\n");
                    }
                }
            }

            testCounter++;
            if (testCounter >= 1000U)
            {
                Demo_SetPwmDuty(testDuty);
                PRINTF("Duty Cycle actual: %d%%\r\n", testDuty);
                
                if (testDuty == 10U) { testDuty = 90U; }
                else { testDuty = 10U; }
                
                testCounter = 0;
            }
        }
    }
    return 0;
}