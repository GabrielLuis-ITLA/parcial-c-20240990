#include "fsl_device_registers.h"
#include "fsl_debug_console.h"
#include "board.h"
#include "pin_mux.h"
#include "clock_config.h"

#include "fsl_gpio.h"
#include "fsl_ctimer.h"
#include "fsl_lpuart.h"

volatile uint32_t g_ms = 0;
volatile uint32_t g_buttonEdgePending = 0U;

int main(void)
{
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitDebugConsole();

    PRINTF("FRDM-MCXA156: consola disponible\r\n");

    uint32_t lastService = g_ms;
    
    for (;;)
    {
        uint32_t now = g_ms;
        
        if ((uint32_t)(now - lastService) >= 1U)
        {
            lastService = now;
        }
    }
    
    return 0;
}