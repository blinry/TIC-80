cmake_minimum_required(VERSION 3.3)

set(VERSION_MAJOR 1)
set(VERSION_MINOR 2)
set(VERSION_REVISION 0)
set(VERSION_STATUS "-dev")

project(TIC-80 VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_REVISION} LANGUAGES C CXX)

configure_file("${PROJECT_SOURCE_DIR}/version.h.in" "${CMAKE_CURRENT_BINARY_DIR}/version.h")

#option(BUILD_WITH_LUA "Lua Enabled" ON)

#option(BUILD_DEMO_CARTS "Demo Carts Enabled" ${BUILD_DEMO_CARTS_DEFAULT})
option(BUILD_PRO "Build PRO version" FALSE)
#option(BUILD_PLAYER "Build standalone players" ${BUILD_PLAYER_DEFAULT})
#option(BUILD_TOUCH_INPUT "Build with touch input support" ${BUILD_TOUCH_INPUT_DEFAULT})
#option(BUILD_STUB "Build stub without editors" OFF)

set(CMAKE_C_STANDARD 11)







set(TIC80CORE_DIR ${CMAKE_SOURCE_DIR}/src)
set(TIC80CORE_SRC
    ${TIC80CORE_DIR}/core/core.c
    ${TIC80CORE_DIR}/core/languages.c
    ${TIC80CORE_DIR}/core/draw.c
    ${TIC80CORE_DIR}/core/io.c
    ${TIC80CORE_DIR}/core/sound.c
    ${TIC80CORE_DIR}/tic.c
    ${TIC80CORE_DIR}/cart.c
    ${TIC80CORE_DIR}/tools.c
    ${TIC80CORE_DIR}/zip.c
    ${TIC80CORE_DIR}/tilesheet.c

    ${TIC80CORE_DIR}/ext/gif.c

    ${TIC80CORE_DIR}/api/lua.c
    #${TIC80CORE_DIR}/api/moonscript.c
    #${TIC80CORE_DIR}/api/fennel.c
    #${TIC80CORE_DIR}/api/js.c
    #${TIC80CORE_DIR}/api/scheme.c
    #${TIC80CORE_DIR}/api/squirrel.c
    ${TIC80CORE_DIR}/api/python.c
    #${TIC80CORE_DIR}/api/wren.c
    #${TIC80CORE_DIR}/api/mruby.c
    #${TIC80CORE_DIR}/api/janet.c
    #${TIC80CORE_DIR}/api/wasm.c
)

add_library(tic80core STATIC ${TIC80CORE_SRC})

target_include_directories(tic80core
    #    PRIVATE
    #        ${THIRDPARTY_DIR}/moonscript
    #        ${THIRDPARTY_DIR}/fennel
    #        ${POCKETPY_DIR}/src
    PUBLIC
        ${CMAKE_SOURCE_DIR}/include
        ${CMAKE_SOURCE_DIR}/src)

target_link_libraries(tic80core
    blipbuf
    z
    m

    gif

    lua
    #quickjs
    #scheme
    #squirrel
    pocketpy
    #wren
    #mruby
    #janet
    #wasm
)

target_compile_definitions(tic80core PRIVATE
    TIC_BUILD_WITH_LUA=1
    TIC_BUILD_WITH_PYTHON=1
)






################################
# TIC-80 studio
################################

set(TIC80LIB_DIR ${CMAKE_SOURCE_DIR}/src)
set(TIC80STUDIO_SRC
    ${TIC80LIB_DIR}/studio/screens/console.c
    ${TIC80LIB_DIR}/studio/screens/run.c
    ${TIC80LIB_DIR}/studio/screens/menu.c
    ${TIC80LIB_DIR}/studio/screens/mainmenu.c
    ${TIC80LIB_DIR}/studio/screens/surf.c
    ${TIC80LIB_DIR}/studio/screens/start.c
    ${TIC80LIB_DIR}/studio/editors/code.c
    ${TIC80LIB_DIR}/studio/editors/sprite.c
    ${TIC80LIB_DIR}/studio/editors/map.c
    ${TIC80LIB_DIR}/studio/editors/world.c
    ${TIC80LIB_DIR}/studio/editors/sfx.c
    ${TIC80LIB_DIR}/studio/editors/music.c
    ${TIC80LIB_DIR}/studio/studio.c
    ${TIC80LIB_DIR}/studio/config.c
    ${TIC80LIB_DIR}/studio/demos.c
    ${TIC80LIB_DIR}/studio/fs.c
    ${TIC80LIB_DIR}/studio/net.c
    ${TIC80LIB_DIR}/ext/md5.c
    ${TIC80LIB_DIR}/ext/history.c
    ${TIC80LIB_DIR}/ext/gif.c
    ${TIC80LIB_DIR}/ext/png.c
)

if(${BUILD_PRO})
    set(TIC80STUDIO_SRC ${TIC80STUDIO_SRC} ${TIC80LIB_DIR}/studio/project.c)
    target_compile_definitions(tic80studio PRIVATE TIC80_PRO)
endif()

#set(TIC80_OUTPUT tic80)

add_library(tic80studio STATIC
    ${TIC80STUDIO_SRC})
    #${DEMO_CARTS_OUT}
    #${CMAKE_SOURCE_DIR}/build/assets/cart.png.dat)

target_include_directories(tic80studio PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_include_directories(tic80studio PUBLIC ${CMAKE_SOURCE_DIR}/src)
target_include_directories(tic80studio PUBLIC ${CMAKE_SOURCE_DIR}/include)

target_link_libraries(tic80studio tic80core zip wave_writer argparse gif png)

target_compile_definitions(tic80studio PUBLIC CRT_SHADER_SUPPORT)
target_compile_definitions(tic80studio PUBLIC BUILD_EDITORS)

target_compile_definitions(tic80studio PRIVATE
    TIC_BUILD_WITH_LUA=1
    TIC_BUILD_WITH_PYTHON=1
)




find_package(SDL2 REQUIRED)

set(TIC80_SRC src/system/sdl/main.c)
add_executable(tic80 ${TIC80_SRC})

target_link_libraries(tic80 tic80studio)
target_link_libraries(tic80 SDL2_gpu)
target_link_libraries(tic80 SDL2::SDL2)

target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/cmake)



#### INSTALLATION

configure_file("${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop.in" "${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop")

install(TARGETS tic80 DESTINATION bin)

SET(TIC80_DESKTOP_DIR     "share/applications/")
SET(TIC80_PIXMAPS_DIR     "share/icons/")

install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop DESTINATION ${TIC80_DESKTOP_DIR})
install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.xml DESTINATION ${TIC80_DESKTOP_DIR})
install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.png DESTINATION ${TIC80_PIXMAPS_DIR})
