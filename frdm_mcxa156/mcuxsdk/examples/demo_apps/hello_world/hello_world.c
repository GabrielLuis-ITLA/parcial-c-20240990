#include "fsl_device_registers.h"
#include "fsl_debug_console.h"
#include "board.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "fsl_gpio.h"
#include "fsl_ctimer.h"
#include "fsl_lpuart.h"

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

int main(void)
{
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitDebugConsole();

    PRINTF("FRDM-MCXA156: consola disponible\r\n");

    RESET_ReleasePeripheralReset(kCTIMER0_RST_SHIFT_RSTn);
    CLOCK_EnableClock(kCLOCK_GateCTIMER0);
    Demo_TickInit(12000000U);

    uint32_t lastService = g_ms;
    uint32_t testCounter = 0;
    
    for (;;)
    {
        uint32_t now = g_ms;
        
        if ((uint32_t)(now - lastService) >= 1U)
        {
            lastService = now;
            testCounter++;

            if (testCounter >= 1000U)
            {
                PRINTF("El tiempo funciona: han pasado %d segundos\r\n", (now / 1000));
                testCounter = 0;
            }
        }
    }
    return 0;
}