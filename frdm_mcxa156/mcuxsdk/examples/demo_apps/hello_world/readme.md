# Code Challenge: Controlador de Iluminación con Consola Serial (Bare-Metal)

**Placa:** FRDM-MCXA156
**Versión de SDK:** 25.03.00 documentado por NXP

## Tabla de Recursos

| Función | Puerto / Pin | Conector | Polaridad | Periférico / Canal | Reloj | IRQ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Tick Periódico (1 ms)** | N/A | N/A | N/A | CTIMER0 (Match 0) | FRO12M (12 MHz) | `CTIMER0_IRQn` |
| **PWM de Hardware (Externa)**| P3_12 | J1, Pin 15 | Activa Alta | CTIMER1 (Match 2) | FRO12M (12 MHz) | N/A |
| **Botón de Usuario (SW2)** | P1_7 | Integrado | Activa Baja | GPIO1 | Reloj del sistema | `GPIO1_IRQn` |
| **LED de Estado (Verde)** | P3_13 | Integrado | Activa Baja | GPIO3 | Reloj del sistema | N/A |
| **Consola Serial (UART)** | - | MCU-Link (USB) | N/A | LPUART0 | Reloj del sistema | `LPUART0_IRQn` |

> **Justificación de diseño (Prevención de conflictos de Pin Mux):** 
> Para cumplir con la restricción del mandato de evitar conflictos de hardware, se configuró el LED de estado utilizando el LED VERDE interno (P3_13). El LED ROJO interno (P3_12) comparte físicamente la misma línea que la salida CTIMER1 exigida para el LED externo del PWM, por lo que su uso simultáneo generaba un conflicto de ruteo (Routing Conflict #63).

## Instrucciones de Compilación y Ejecución

1. Abrir el entorno VS Code con la extensión de NXP MCUXpresso.
2. Sincronizar las herramientas utilizando CMake/West si el IDE lo solicita.
3. Hacer clic en **Build** (barra inferior) para compilar la aplicación Bare-Metal.
4. Conectar la placa FRDM-MCXA156 por el puerto USB "MCU-Link".
5. Iniciar la sesión de depuración haciendo clic en **Debug** (F5).
6. Abrir una terminal serial virtual con la configuración: **115200 baudios, 8 bits, sin paridad, 1 bit de parada y sin control de flujo**.

## Diagrama y Lógica de Estados

La máquina de estados finitos (FSM) opera sin bloqueos (non-blocking) con las siguientes transiciones validadas mediante interrupciones GPIO y un temporizador base (Tick 1 ms):

*   **MANUAL (Estado Inicial):**
    *   **Comportamiento:** LED de estado encendido fijo. PWM fijo al 25% o al valor establecido por `DUTY n`. Frecuencia inicial 1000 Hz.
    *   **Transición:** Pulsación corta (≥ 30 ms y < 1500 ms) pasa al modo `AUTO`.
*   **AUTO:**
    *   **Comportamiento:** LED de estado alterna cada 500 ms. El PWM genera una rampa triangular del 10% al 90%, incrementando y decrementando a pasos de 1 punto porcentual cada 20 ms. (Tiempo total del ciclo: 3.2 s).
    *   **Transición:** Pulsación corta restaura el estado a `MANUAL` aplicando el último duty cycle guardado.
*   **PAUSA:**
    *   **Comportamiento:** LED de estado alterna de forma rápida (125 ms). La salida PWM cae a un 0% absoluto. Todos los comandos UART que intenten alterar los parámetros devuelven `ERR STATE`.
    *   **Transición:** Se entra o se sale de `PAUSA` exclusivamente mediante una pulsación larga (≥ 1500 ms). Al hacer `RESUME`, se restaura el estado, el duty cycle y la dirección de la rampa exactos previos a la pausa.

## Tratamiento Especial Implementado (Registro PWM)
La rúbrica indica comprobar los niveles del 0% y 100% para evitar pulsos residuales. Durante las pruebas con multímetro, se determinó que la función nativa del SDK (`CTIMER_UpdatePwmDutycycle`) colapsa la señal a 0V al solicitar un 100% (Active-Low interno).
Para solucionar esto y satisfacer los requisitos eléctricos (Activa Alta para la protoboard externa), se implementó un control *Bare-Metal* modificando directamente el registro Match (`APP_PWM_TIMER->MR`). De esta forma, el 100% inyecta 3.3V constantes sin pulsos caídos, y el 0% detiene el match entregando un 0V absoluto.