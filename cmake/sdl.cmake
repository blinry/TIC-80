find_package(SDL2 REQUIRED)

set(TIC80_SRC src/system/sdl/main.c)
add_executable(tic80 ${TIC80_SRC})

target_link_libraries(tic80 SDL2_gpu)
target_link_libraries(tic80 tic80studio)
target_link_libraries(tic80 SDL2::SDL2)

target_include_directories(tic80 PRIVATE $ENV{SDLGPU_INCLUDE_DIR})

if(LINUX)
    configure_file("${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop.in" "${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop")

    install(TARGETS tic80 DESTINATION bin)

    SET(TIC80_DESKTOP_DIR     "share/applications/")
    SET(TIC80_PIXMAPS_DIR     "share/icons/")

    install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.desktop DESTINATION ${TIC80_DESKTOP_DIR})
    install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.xml DESTINATION ${TIC80_DESKTOP_DIR})
    install (FILES ${PROJECT_SOURCE_DIR}/build/linux/tic80.png DESTINATION ${TIC80_PIXMAPS_DIR})
endif()
