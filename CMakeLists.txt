cmake_minimum_required(VERSION 3.16)

project(QFace VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2.4  COMPONENTS Quick QuickControls2 REQUIRED)

qt_add_executable(
    appQFace
    main.cpp
)

set(qml_files
    view/main.qml
    view/LoginPage.qml
    view/MainPage.qml
)

set(icon_files
    assets/icon/feedback.png
    assets/icon/clock.png
    assets/icon/worker.png
    assets/icon/logo.ico
)

qt_add_qml_module(appQFace
    URI QFace
    VERSION 1.0
    QML_FILES ${qml_files}
    RESOURCES ${icon_files}
)

set_target_properties(appQFace PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(
    appQFace
    PRIVATE
    Qt6::Quick
    Qt6::QuickControls2)

include(GNUInstallDirs)
install(TARGETS appQFace
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
