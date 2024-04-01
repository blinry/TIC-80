cmake_minimum_required(VERSION 3.3)

set(VERSION_MAJOR 1)
set(VERSION_MINOR 2)
set(VERSION_REVISION 0)
set(VERSION_STATUS "-dev")

project(TIC-80 VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_REVISION} LANGUAGES C CXX)

configure_file("${PROJECT_SOURCE_DIR}/version.h.in" "${CMAKE_CURRENT_BINARY_DIR}/version.h")

option(BUILD_WITH_LUA "Lua Enabled" ON)

#option(BUILD_SDL "SDL Enabled" ON)
#option(BUILD_SDLGPU "SDL GPU Enabled" OFF)
#option(BUILD_SOKOL "Sokol Enabled" OFF)
#option(BUILD_LIBRETRO "libretro Enabled" ${BUILD_LIBRETRO_DEFAULT})
#option(BUILD_DEMO_CARTS "Demo Carts Enabled" ${BUILD_DEMO_CARTS_DEFAULT})
#option(BUILD_PRO "Build PRO version" FALSE)
#option(BUILD_PLAYER "Build standalone players" ${BUILD_PLAYER_DEFAULT})
#option(BUILD_TOUCH_INPUT "Build with touch input support" ${BUILD_TOUCH_INPUT_DEFAULT})
#option(BUILD_STUB "Build stub without editors" OFF)

set(LINUX TRUE)

#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
#if (NOT DEFINED CMAKE_POSITION_INDEPENDENT_CODE)
#  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
#endif()

set(CMAKE_C_STANDARD 11)

#set(THIRDPARTY_DIR ${CMAKE_SOURCE_DIR}/vendor)
#
#include(cmake/gif.cmake)
#include(cmake/blipbuf.cmake)
#
#include(cmake/lua.cmake)
#include(cmake/wren.cmake)
#include(cmake/mruby.cmake)
#include(cmake/wasm.cmake)
#include(cmake/scheme.cmake)
#include(cmake/squirrel.cmake)
#include(cmake/pocketpy.cmake)
#include(cmake/quickjs.cmake)
#include(cmake/janet.cmake)
#
include(cmake/core.cmake)
#
#include(cmake/zlib.cmake)
#include(cmake/zip.cmake)
#include(cmake/tools.cmake)
#include(cmake/wave.cmake)
#include(cmake/argparse.cmake)
#include(cmake/naett.cmake)
#include(cmake/png.cmake)
#
include(cmake/studio.cmake)
#
#include(cmake/sdl.cmake)
#include(cmake/sokol.cmake)
#include(cmake/libretro.cmake)
#include(cmake/n3ds.cmake)
#
#include(cmake/stub.cmake)
#include(cmake/install.cmake)

find_package(SDL2 REQUIRED)

set(TIC80_SRC src/system/sdl/main.c)
add_executable(tic80 ${TIC80_SRC})

target_link_libraries(tic80 SDL2_gpu)
target_link_libraries(tic80 tic80studio)
target_link_libraries(tic80 SDL2::SDL2)

target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/cmake)

target_include_directories(tic80 PRIVATE $ENV{SDLGPU_INCLUDE_DIR})
target_include_directories(tic80 PRIVATE $ENV{BLIPBUF_INCLUDE_DIR})

#target_compile_definitions(tic80 PRIVATE TIC_BUILD_WITH_LUA=1)

#if(LINUX)
#    configure_file("${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop.in" "${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop")
#
#    install(TARGETS tic80 DESTINATION bin)
#
#    SET(TIC80_DESKTOP_DIR     "share/applications/")
#    SET(TIC80_PIXMAPS_DIR     "share/icons/")
#
#    install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop DESTINATION ${TIC80_DESKTOP_DIR})
#    install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.xml DESTINATION ${TIC80_DESKTOP_DIR})
#    install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.png DESTINATION ${TIC80_PIXMAPS_DIR})
#endif()
