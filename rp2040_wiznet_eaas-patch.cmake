# CMake minimum required version
cmake_minimum_required(VERSION 3.12)

# Find git
find_package(Git)

if(NOT Git_FOUND)
	message(FATAL_ERROR "Could not find 'git' tool for RP2040-WIZNET-EAAS patching")
endif()

message("RP2040-WIZNET-EAAS patch utils found")

set(RP2040_WIZNET_EAAS_SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(PICO_EXTRAS_SRC_DIR "${RP2040_WIZNET_EAAS_SRC_DIR}/libraries/pico-extras")
set(PICO_SDK_SRC_DIR "${RP2040_WIZNET_EAAS_SRC_DIR}/libraries/pico-sdk")
set(PICO_SDK_TINYUSB_SRC_DIR "${RP2040_WIZNET_EAAS_SRC_DIR}/libraries/lib/tinyusb")

set(AWS_IOT_DEVICE_SDK_EMBEDDED_C_SRC_DIR "${RP2040_WIZNET_EAAS_SRC_DIR}/libraries/aws-iot-device-sdk-embedded-C")
set(AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_SRC_DIR "${RP2040_WIZNET_EAAS_SRC_DIR}/libraries/aws-iot-device-sdk-embedded-C/libraries/standard/coreHTTP")
set(AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREMQTT_SRC_DIR "${RP2040_WIZNET_EAAS_SRC_DIR}/libraries/aws-iot-device-sdk-embedded-C/libraries/standard/coreMQTT")
set(AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_HTTP_PARSER_SRC_DIR "${RP2040_WIZNET_EAAS_SRC_DIR}/libraries/aws-iot-device-sdk-embedded-C/libraries/standard/coreHTTP/source/dependency/3rdparty/http_parser")

set(RP2040_WIZNET_EAAS_PATCH_DIR "${RP2040_WIZNET_EAAS_SRC_DIR}/patches")

# Delete untracked files in FreeRTOS-Kernel
if(EXISTS "${FREERTOS_KERNEL_SRC_DIR}/.git")
	message("cleaning FreeRTOS-Kernel...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${FREERTOS_KERNEL_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${FREERTOS_KERNEL_SRC_DIR} reset --hard)
	message("FreeRTOS-Kernel cleaned")
endif()

#Delete untracked files in ioLibrary_Driver
if(EXISTS "${IOLIBRARY_DRIVER_SRC_DIR}/.git")
	message("cleaning ioLibrary_Driver...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${IOLIBRARY_DRIVER_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${IOLIBRARY_DRIVER_SRC_DIR} reset --hard)
	message("ioLibrary_Driver cleaned")
endif()

#Delete untracked files in mbedtls
if(EXISTS "${MBEDTLS_SRC_DIR}/.git")
	message("cleaning mbedtls...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${MBEDTLS_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${MBEDTLS_SRC_DIR} reset --hard)
	message("mbedtls cleaned")
endif()

# Delete untracked files in pico-extras
if(EXISTS "${PICO_EXTRAS_SRC_DIR}/.git")
	message("cleaning pico-extras...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PICO_EXTRAS_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PICO_EXTRAS_SRC_DIR} reset --hard)
	message("pico-extras cleaned")
endif()

# Delete untracked files in pico-sdk
if(EXISTS "${PICO_SDK_SRC_DIR}/.git")
	message("cleaning pico-sdk...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PICO_SDK_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PICO_SDK_SRC_DIR} reset --hard)
	message("pico-sdk cleaned")
endif()

execute_process(COMMAND ${GIT_EXECUTABLE} -C ${RP2040_WIZNET_EAAS_SRC_DIR} submodule update --init)

# Delete untracked files in tinyusb
if(EXISTS "${PICO_SDK_TINYUSB_SRC_DIR}/.git")
	message("cleaning pico-sdk tinyusb...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PICO_SDK_TINYUSB_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PICO_SDK_TINYUSB_SRC_DIR} reset --hard)
	message("pico-sdk tinyusb cleaned")
endif()

execute_process(COMMAND ${GIT_EXECUTABLE} -C ${PICO_SDK_SRC_DIR} submodule update --init)

# Delete untracked files in coreHTTP
if(EXISTS "${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_SRC_DIR}/.git")
	message("cleaning aws-iot-device-sdk-embedded-C coreHTTP...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_SRC_DIR} reset --hard)
	message("aws-iot-device-sdk-embedded-C coreHTTP cleaned")
endif()

# Delete untracked files in coreMQTT
if(EXISTS "${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREMQTT_SRC_DIR}/.git")
	message("cleaning aws-iot-device-sdk-embedded-C coreMQTT...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREMQTT_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREMQTT_SRC_DIR} reset --hard)
	message("aws-iot-device-sdk-embedded-C coreMQTT cleaned")
endif()

message("aws-iot-device-sdk-embedded-C submodule update")
execute_process(COMMAND ${GIT_EXECUTABLE} -C ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_SRC_DIR} submodule update --init)

# Delete untracked files in http_parser
if(EXISTS "${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_HTTP_PARSER_SRC_DIR}/.git")
	message("cleaning aws-iot-device-sdk-embedded-C coreHTTP http_parser...")
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_HTTP_PARSER_SRC_DIR} clean -fdx)
	execute_process(COMMAND ${GIT_EXECUTABLE} -C ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_HTTP_PARSER_SRC_DIR} reset --hard)
	message("aws-iot-device-sdk-embedded-C coreHTTP http_parser cleaned")
endif()

execute_process(COMMAND ${GIT_EXECUTABLE} -C ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_SRC_DIR} submodule update --init)

# coreHTTP patch
message("submodules aws-iot-device-sdk-embedded-C coreHTTP initialised")
file(GLOB AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_PATCHES 
	"${RP2040_WIZNET_EAAS_PATCH_DIR}/01_aws_iot_device_sdk_embedded_c_corehttp_network_interface.patch"
	)

foreach(AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_PATCH IN LISTS AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_PATCHES)
	message("Running patch ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_PATCH}")
	execute_process(
		COMMAND ${GIT_EXECUTABLE} apply --ignore-whitespace ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_PATCH}
		WORKING_DIRECTORY ${AWS_IOT_DEVICE_SDK_EMBEDDED_C_COREHTTP_SRC_DIR}
	)
endforeach()
