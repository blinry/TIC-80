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
)

if(BUILD_WITH_LUA)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/lua.c)
endif()

if(BUILD_WITH_MOON)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/moonscript.c)
endif()

if(BUILD_WITH_FENNEL)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/fennel.c)
endif()

if(BUILD_WITH_JS)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/js.c)
endif()

if(BUILD_WITH_SCHEME)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/scheme.c)
endif()

if(BUILD_WITH_SQUIRREL)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/squirrel.c)
endif()

if(BUILD_WITH_PYTHON)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/python.c)
endif()

if(BUILD_WITH_WREN)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/wren.c)
endif()

if(BUILD_WITH_MRUBY)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/mruby.c)
endif()

if(BUILD_WITH_JANET)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/janet.c)
endif()

if(BUILD_WITH_WASM)
    list(APPEND TIC80CORE_SRC ${TIC80CORE_DIR}/api/wasm.c)
endif()

set(TIC80CORE_SRC ${TIC80CORE_SRC} ${TIC80CORE_DIR}/ext/gif.c)

add_library(tic80core STATIC ${TIC80CORE_SRC})

if (FREEBSD)
    target_include_directories(tic80core PRIVATE ${SYSROOT_PATH}/usr/local/include)
    target_link_directories(tic80core PRIVATE ${SYSROOT_PATH}/usr/local/lib)
endif()

target_include_directories(tic80core
    PRIVATE
        ${THIRDPARTY_DIR}/moonscript
        ${THIRDPARTY_DIR}/fennel
        ${POCKETPY_DIR}/src
    PUBLIC
        ${CMAKE_SOURCE_DIR}/include
        ${CMAKE_SOURCE_DIR}/src)

target_link_libraries(tic80core blipbuf z)
#target_include_directories(tic80core{SCRIPT} PUBLIC $ENV{SDLGPU_INCLUDE_DIR})

if(BUILD_WITH_LUA)
    target_link_libraries(tic80core lua)
    target_compile_definitions(tic80core PRIVATE TIC_BUILD_WITH_LUA=1)
endif()

if(BUILD_WITH_JS)
    target_link_libraries(tic80core quickjs)
endif()

if(BUILD_WITH_SCHEME)
    target_link_libraries(tic80core scheme)
endif()

if(BUILD_WITH_SQUIRREL)
    target_link_libraries(tic80core squirrel)
endif()

if(BUILD_WITH_PYTHON)
    target_link_libraries(tic80core python)
endif()

if(BUILD_WITH_WREN)
    target_link_libraries(tic80core wren)
endif()

if(BUILD_WITH_MRUBY)
    target_link_libraries(tic80core mruby)
endif()

if(BUILD_WITH_JANET)
    target_link_libraries(tic80core janet)
endif()

if(BUILD_WITH_WASM)
    target_link_libraries(tic80core wasm)
endif()

#target_compile_definitions(tic80core PRIVATE BUILD_DEPRECATED)
target_link_libraries(tic80core gif)

target_link_libraries(tic80core m)
