# Install script for directory: /Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Users/gabrielluis/.mcuxpressotools/arm-gnu-toolchain-14.2.rel1-darwin-x86_64-arm-none-eabi/bin/arm-none-eabi-objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/cmake/extension/flash/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/cmake/extension/usage/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/cmake/extension/reports/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/devices/MCX/MCXA/MCXA156/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/examples/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/aoi/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cdog/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/common/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/crc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/ctimer/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/dac_1/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/edma4/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/edma_unified/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/eim/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/eqdc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/erm/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexcan/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexpwm/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/glikey/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/gpio/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/i3c/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/inputmux/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/lpadc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/lpc_freqme/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/lpcmp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/lpi2c/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/lpspi/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/lptmr/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/lpuart/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/mcx_cmc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/mcx_spc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/mcx_vbat/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/opamp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/ostimer/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/port/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/pwm/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/smartcard/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/trdc_1/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/utick/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/waketimer/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/wuu/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/wwdt/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/armv7-m7/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/armv8-a/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/cache64/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/llc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/lmem/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/lpcac/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/lpcac_n4a_mcxn/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/lplmem/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/cache/xcache/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/a-format/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/biss/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/camera/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/endat2p2/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/i2c/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/i2s/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/mculcd/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/qspi/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/spi/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/t-format/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/drivers/flexio/uart/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/components/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/rtos/freertos/freertos-kernel/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/usb/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/fatfs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/littlefs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/rtcesl/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/motor_control/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/examples/lvgl_examples/lvgl_sdk/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/mcuboot_opensource/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/freemaster/mcux/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/safety_iec60730b/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/cadence/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/emwin/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/canopennode/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/middleware/mstp-lib/cmake_install.cmake")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
if(CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_COMPONENT MATCHES "^[a-zA-Z0-9_.+-]+$")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
  else()
    string(MD5 CMAKE_INST_COMP_HASH "${CMAKE_INSTALL_COMPONENT}")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INST_COMP_HASH}.txt")
    unset(CMAKE_INST_COMP_HASH)
  endif()
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/gabrielluis/parcial-c-20240990/frdm_mcxa156/mcuxsdk/examples/demo_apps/hello_world/debug/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
