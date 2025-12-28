#pragma once
#include <string>

class WallpaperEngine {
public:
    WallpaperEngine();
    ~WallpaperEngine();
    
    void start();
    void stop();
    void setVideoPath(const std::string& path);
    void play();
    void pause();
    void resume();
    void stopVideo();
    void setMuted(bool muted);
    void setScaleMode(int mode); // 0=Fill, 1=Fit, 2=Stretch
    
private:
    class Impl;
    Impl* impl;
};