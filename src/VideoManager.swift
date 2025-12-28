import Foundation

class VideoManager: ObservableObject {
    @Published var status = "Idle"
    @Published var selectedFileName: String?
    
    private var bridge = CppBridge()
    private var currentVideoPath: String?
    
    func initializeEngine() {
        bridge.initializeEngine()
    }
    
    func loadVideo(url: URL) {
        let path = url.path
        currentVideoPath = path
        selectedFileName = url.lastPathComponent
        bridge.playVideo(path: path)
        status = "Playing"
    }
    
    func play() {
        // Only allow play if we have a video loaded and are not already playing
        guard let path = currentVideoPath else { return }
        guard status != "Playing" else { return }
        
        if status == "Paused" {
            bridge.resumeVideo()
        } else {
            bridge.playVideo(path: path)
        }
        status = "Playing"
    }
    
    func pause() {
        // Only allow pause if currently playing
        guard status == "Playing" else { return }
        
        bridge.pauseVideo()
        status = "Paused"
    }
    
    func stop() {
        bridge.stopVideo()
        status = "Stopped"
        // Keep filename so user can replay without re-loading
    }
}
