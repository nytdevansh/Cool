import Foundation

class CppBridge {
    private var engine: UnsafeMutableRawPointer?
    
    func initializeEngine() {
        // Initialize C++ engine
        engine = createWallpaperWindow()
    }
    
    deinit {
        if let engine = engine {
            destroyWallpaperWindow(engine)
        }
    }
    
    func playVideo(path: String) {
        guard let engine = engine else { return }
        path.withCString { cPath in
            playVideoC(engine, cPath)
        }
    }
    
    func pauseVideo() {
        guard let engine = engine else { return }
        pauseVideoC(engine)
    }
    
    func resumeVideo() {
        guard let engine = engine else { return }
        resumeVideoC(engine)
    }
    
    func stopVideo() {
        guard let engine = engine else { return }
        stopVideoC(engine)
    }
}

// Declare C bridge functions
@_silgen_name("createWallpaperWindow")
func createWallpaperWindow() -> UnsafeMutableRawPointer?

@_silgen_name("destroyWallpaperWindow")
func destroyWallpaperWindow(_ window: UnsafeMutableRawPointer) -> Void

@_silgen_name("playVideo")
func playVideoC(_ window: UnsafeMutableRawPointer, _ path: UnsafePointer<CChar>) -> Void

@_silgen_name("pauseVideo")
func pauseVideoC(_ window: UnsafeMutableRawPointer) -> Void

@_silgen_name("resumeVideo")
func resumeVideoC(_ window: UnsafeMutableRawPointer) -> Void

@_silgen_name("stopVideo")
func stopVideoC(_ window: UnsafeMutableRawPointer) -> Void

@_silgen_name("setVideoMuted")
func setVideoMuted(_ window: UnsafeMutableRawPointer, _ muted: Bool) -> Void
