import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    let videoManager = VideoManager()
    var mainWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Initialize C++ engine
        videoManager.initializeEngine()
        
        // Ensure app appears in dock and activates
        NSApplication.shared.setActivationPolicy(.regular)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

@main
struct CoolApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.videoManager)
                .frame(width: 356, height: 560, alignment: .topLeading)
                .onAppear {
                    // Set window size to match content exactly
                    if let window = NSApplication.shared.windows.first {
                        window.setFrame(NSRect(x: window.frame.origin.x, y: window.frame.origin.y, width: 356, height: 560), display: true)
                        window.isMovableByWindowBackground = true
                    }
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentMinSize)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About Cool") {
                    NSApp.orderFrontStandardAboutPanel(options: [
                        NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                            string: "Video wallpaper engine for macOS",
                            attributes: [.font: NSFont.systemFont(ofSize: 11)]
                        )
                    ])
                }
            }
        }
    }
}
