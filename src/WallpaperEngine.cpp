#include "WallpaperEngine.hpp"
#include <iostream>

// Forward declare Obj-C++ bridge functions WITH extern "C"
extern "C" {
    void* createWallpaperWindow();
    void destroyWallpaperWindow(void* window);
    void playVideo(void* window, const char* path);
    void setVideoMuted(void* window, bool muted);
}

class WallpaperEngine::Impl {
public:
    void* windowHandle = nullptr;
    std::string currentVideoPath;
    bool isMuted = false;
};

WallpaperEngine::WallpaperEngine() {
    impl = new Impl();
}

WallpaperEngine::~WallpaperEngine() {
    stop();
    delete impl;
}

void WallpaperEngine::start() {
    std::cout << "🎬 Starting Cool wallpaper engine...\n";
    impl->windowHandle = createWallpaperWindow();
}

void WallpaperEngine::stop() {
    if (impl->windowHandle) {
        destroyWallpaperWindow(impl->windowHandle);
        impl->windowHandle = nullptr;
    }
}

void WallpaperEngine::setVideoPath(const std::string& path) {
    impl->currentVideoPath = path;
    if (impl->windowHandle) {
        playVideo(impl->windowHandle, path.c_str());
    }
}

void WallpaperEngine::setMuted(bool muted) {
    impl->isMuted = muted;
    if (impl->windowHandle) {
        setVideoMuted(impl->windowHandle, muted);
    }
}

void WallpaperEngine::setScaleMode(int mode) {
    // TODO: Implement scaling modes
}