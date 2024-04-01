cmake_minimum_required(VERSION 3.3)

set(VERSION_MAJOR 1)
set(VERSION_MINOR 2)
set(VERSION_REVISION 0)
set(VERSION_STATUS "-dev")

project(TIC-80 VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_REVISION} LANGUAGES C CXX)

configure_file("${PROJECT_SOURCE_DIR}/version.h.in" "${CMAKE_CURRENT_BINARY_DIR}/version.h")

#option(BUILD_DEMO_CARTS "Demo Carts Enabled" ${BUILD_DEMO_CARTS_DEFAULT})
option(BUILD_PRO "Build PRO version" FALSE)
#option(BUILD_TOUCH_INPUT "Build with touch input support" ${BUILD_TOUCH_INPUT_DEFAULT})

set(CMAKE_C_STANDARD 11)


find_package(SDL2 REQUIRED)

set(TIC80_SRC
    src/system/sdl/main.c

    src/core/core.c
    src/core/languages.c
    src/core/draw.c
    src/core/io.c
    src/core/sound.c
    src/tic.c
    src/cart.c
    src/tools.c
    src/zip.c
    src/tilesheet.c

    src/ext/gif.c

    src/api/lua.c
    #src/api/moonscript.c
    #src/api/fennel.c
    #src/api/js.c
    #src/api/scheme.c
    #src/api/squirrel.c
    src/api/python.c
    #src/api/wren.c
    src/api/mruby.c
    #src/api/janet.c
    #src/api/wasm.c

    src/studio/screens/console.c
    src/studio/screens/run.c
    src/studio/screens/menu.c
    src/studio/screens/mainmenu.c
    src/studio/screens/surf.c
    src/studio/screens/start.c
    src/studio/editors/code.c
    src/studio/editors/sprite.c
    src/studio/editors/map.c
    src/studio/editors/world.c
    src/studio/editors/sfx.c
    src/studio/editors/music.c
    src/studio/studio.c
    src/studio/config.c
    src/studio/demos.c
    src/studio/fs.c
    src/studio/net.c
    src/ext/md5.c
    src/ext/history.c
    src/ext/png.c
)

add_executable(tic80 ${TIC80_SRC})

target_link_libraries(tic80
    SDL2_gpu
    SDL2::SDL2

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
    mruby
    #janet
    #wasm

    zip
    wave_writer
    argparse
    png
)

target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_include_directories(tic80 PRIVATE ${PROJECT_SOURCE_DIR}/cmake)


target_compile_definitions(tic80 PRIVATE
    TIC_BUILD_WITH_LUA=1
    TIC_BUILD_WITH_PYTHON=1
    TIC_BUILD_WITH_MRUBY=1

    CRT_SHADER_SUPPORT
    BUILD_EDITORS
)

# TODO: add to sources properly
#if(${BUILD_PRO})
#    set(TIC80STUDIO_SRC ${TIC80STUDIO_SRC} ${TIC80LIB_DIR}/studio/project.c)
#    target_compile_definitions(tic80 PRIVATE TIC80_PRO)
#endif()

#### INSTALLATION

configure_file("${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop.in" "${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop")

install(TARGETS tic80 DESTINATION bin)

SET(TIC80_DESKTOP_DIR     "share/applications/")
SET(TIC80_PIXMAPS_DIR     "share/icons/")

install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop DESTINATION ${TIC80_DESKTOP_DIR})
install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.xml DESTINATION ${TIC80_DESKTOP_DIR})
install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.png DESTINATION ${TIC80_PIXMAPS_DIR})
