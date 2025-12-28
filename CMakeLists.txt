cmake_minimum_required(VERSION 3.20)
project(Cool)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable Objective-C++
enable_language(OBJCXX)
set(CMAKE_OBJCXX_STANDARD 17)

# Enable Swift
enable_language(Swift)

# Find macOS frameworks
find_library(COCOA_LIBRARY Cocoa REQUIRED)
find_library(AVFOUNDATION_LIBRARY AVFoundation REQUIRED)
find_library(COREMEDIA_LIBRARY CoreMedia REQUIRED)
find_library(COREVIDEO_LIBRARY CoreVideo REQUIRED)
find_library(SWIFTUI_LIBRARY SwiftUI REQUIRED)

# Source files (C++, Obj-C++)
set(SOURCES
    src/WallpaperEngine.cpp
    src/WindowManager.mm
)

# Swift files
set(SWIFT_SOURCES
    src/CoolApp.swift
    src/ContentView.swift
    src/VideoManager.swift
    src/CppBridge.swift
)

# Create app bundle
add_executable(Cool MACOSX_BUNDLE ${SOURCES} ${SWIFT_SOURCES})

# Link frameworks
target_link_libraries(Cool
    ${COCOA_LIBRARY}
    ${AVFOUNDATION_LIBRARY}
    ${COREMEDIA_LIBRARY}
    ${COREVIDEO_LIBRARY}
    ${SWIFTUI_LIBRARY}
)

# Set bundle properties
set_target_properties(Cool PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_SOURCE_DIR}/Info.plist
    MACOSX_BUNDLE_BUNDLE_NAME "Cool"
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.yourname.cool"
    MACOSX_BUNDLE_BUNDLE_VERSION "1.0"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
    MACOSX_BUNDLE_ICON_FILE "Cool"
)

# Copy icon to app bundle resources
add_custom_command(TARGET Cool POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory
        $<TARGET_BUNDLE_CONTENT_DIR:Cool>/Resources
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/Cool.icns
        $<TARGET_BUNDLE_CONTENT_DIR:Cool>/Resources/Cool.icns
    VERBATIM
)

# Copy resources
file(COPY resources/ DESTINATION ${CMAKE_BINARY_DIR}/Cool.app/Contents/Resources/)