cmake_minimum_required(VERSION 3.20)
project(Cool)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable Objective-C++
enable_language(OBJCXX)
set(CMAKE_OBJCXX_STANDARD 17)

# Find macOS frameworks
find_library(COCOA_LIBRARY Cocoa REQUIRED)
find_library(AVFOUNDATION_LIBRARY AVFoundation REQUIRED)
find_library(COREMEDIA_LIBRARY CoreMedia REQUIRED)
find_library(COREVIDEO_LIBRARY CoreVideo REQUIRED)

# Source files
set(SOURCES
    src/main.mm
    src/WallpaperEngine.cpp
    src/WindowManager.mm
)

# Create app bundle
add_executable(Cool MACOSX_BUNDLE ${SOURCES})

# Link frameworks
target_link_libraries(Cool
    ${COCOA_LIBRARY}
    ${AVFOUNDATION_LIBRARY}
    ${COREMEDIA_LIBRARY}
    ${COREVIDEO_LIBRARY}
)

# Set bundle properties
set_target_properties(Cool PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_SOURCE_DIR}/Info.plist
    MACOSX_BUNDLE_BUNDLE_NAME "Cool"
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.yourname.cool"
    MACOSX_BUNDLE_BUNDLE_VERSION "1.0"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
)

# Copy resources
file(COPY resources/ DESTINATION ${CMAKE_BINARY_DIR}/Cool.app/Contents/Resources/)