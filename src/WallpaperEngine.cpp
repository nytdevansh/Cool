#include "WallpaperEngine.hpp"
#include <iostream>

// Forward declare Obj-C++ bridge functions WITH extern "C"
extern "C" {
    void* createWallpaperWindow();
    void destroyWallpaperWindow(void* window);
    void playVideo(void* window, const char* path);
    void pauseVideo(void* window);
    void resumeVideo(void* window);
    void stopVideo(void* window);
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

void WallpaperEngine::play() {
    if (impl->windowHandle && !impl->currentVideoPath.empty()) {
        playVideo(impl->windowHandle, impl->currentVideoPath.c_str());
    }
}

void WallpaperEngine::pause() {
    if (impl->windowHandle) {
        pauseVideo(impl->windowHandle);
    }
}

void WallpaperEngine::resume() {
    if (impl->windowHandle) {
        resumeVideo(impl->windowHandle);
    }
}

void WallpaperEngine::stopVideo() {
    if (impl->windowHandle) {
        ::stopVideo(impl->windowHandle);
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