import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @EnvironmentObject var videoManager: VideoManager
    @State private var isShowingFilePicker = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isHoveringUpload = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.95, blue: 0.97),
                    Color(red: 0.98, green: 0.98, blue: 0.99)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Cool")
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    
                    Text("Video Wallpapers")
                        .font(.system(size: 13, weight: .medium, design: .default))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                
                // Video Preview Card
                VStack(spacing: 12) {
                    ZStack {
                        // Background with glassmorphism effect
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.7),
                                        Color.white.opacity(0.5)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color.white.opacity(0.8),
                                                Color.white.opacity(0.2)
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1.5
                                    )
                            )
                            .frame(height: 160)
                        
                        // Animated border on playing
                        if videoManager.status == "Playing" {
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.green.opacity(0.8),
                                            Color.green.opacity(0.3)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                                .frame(height: 160)
                        }
                        
                        // Content
                        VStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(
                                        RadialGradient(
                                            gradient: Gradient(colors: [
                                                statusColor.opacity(0.2),
                                                statusColor.opacity(0.05)
                                            ]),
                                            center: .center,
                                            startRadius: 0,
                                            endRadius: 20
                                        )
                                    )
                                    .frame(width: 44, height: 44)
                                
                                Image(systemName: videoManager.status == "Playing" ? "film.fill" : "film")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(statusColor)
                            }
                            
                            Text(videoManager.selectedFileName ?? "No video selected")
                                .font(.system(size: 13, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .lineLimit(1)
                                .truncationMode(.middle)
                            
                            Text(statusSubtext)
                                .font(.system(size: 11, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // Status bar with animated indicator
                    HStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(statusColor.opacity(0.2))
                                .frame(width: 8, height: 8)
                            
                            if videoManager.status == "Playing" {
                                Circle()
                                    .fill(statusColor)
                                    .frame(width: 6, height: 6)
                                    .scaleEffect(1.2)
                                    .animation(
                                        Animation.easeInOut(duration: 1).repeatForever(autoreverses: true),
                                        value: videoManager.status
                                    )
                            } else {
                                Circle()
                                    .fill(statusColor)
                                    .frame(width: 6, height: 6)
                            }
                        }
                        
                        Text("Status: \(videoManager.status)")
                            .font(.system(size: 12, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(8)
                }
                
                // Control Buttons
                HStack(spacing: 10) {
                    // Play Button
                    Button(action: videoManager.play) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.green.opacity(0.8))
                            )
                            .foregroundColor(.white)
                    }
                    .disabled(videoManager.selectedFileName == nil || videoManager.status == "Playing")
                    .opacity(videoManager.selectedFileName == nil || videoManager.status == "Playing" ? 0.5 : 1.0)
                    
                    // Pause Button
                    Button(action: videoManager.pause) {
                        Image(systemName: "pause.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.orange.opacity(0.8))
                            )
                            .foregroundColor(.white)
                    }
                    .disabled(videoManager.status != "Playing")
                    .opacity(videoManager.status != "Playing" ? 0.5 : 1.0)
                    
                    // Stop Button
                    Button(action: videoManager.stop) {
                        Image(systemName: "stop.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.red.opacity(0.8))
                            )
                            .foregroundColor(.white)
                    }
                    .disabled(videoManager.status == "Stopped" || videoManager.status == "Idle")
                    .opacity(videoManager.status == "Stopped" || videoManager.status == "Idle" ? 0.5 : 1.0)
                    
                    Spacer()
                    
                    // Folder Button
                    Button(action: { isShowingFilePicker = true }) {
                        Image(systemName: "folder.badge.plus")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.blue.opacity(0.8))
                            )
                            .foregroundColor(.white)
                    }
                }
                .keyboardShortcut(.space, modifiers: [])
                
                // Upload Video Button
                Button(action: { isShowingFilePicker = true }) {
                    HStack(spacing: 8) {
                        Image(systemName: "square.and.arrow.down.fill")
                        Text("Upload Video")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue.opacity(isHoveringUpload ? 0.9 : 0.8),
                                Color.blue.opacity(isHoveringUpload ? 0.8 : 0.7)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(.plain)
                .onHover { hovering in
                    isHoveringUpload = hovering
                }
                .scaleEffect(isHoveringUpload ? 1.02 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isHoveringUpload)
                
                Spacer()
            }
            .padding(16)
            .frame(width: 340, alignment: .topLeading)
        }
        .fileImporter(
            isPresented: $isShowingFilePicker,
            allowedContentTypes: [.mpeg4Movie, .quickTimeMovie, .avi, .movie, .video],
            onCompletion: { result in
                switch result {
                case .success(let url):
                    let accessing = url.startAccessingSecurityScopedResource()
                    defer {
                        if accessing {
                            url.stopAccessingSecurityScopedResource()
                        }
                    }
                    
                    guard FileManager.default.isReadableFile(atPath: url.path) else {
                        errorMessage = "Unable to read video file"
                        showError = true
                        return
                    }
                    
                    videoManager.loadVideo(url: url)
                    
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    showError = true
                }
            }
        )
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    var statusColor: Color {
        switch videoManager.status {
        case "Playing":
            return .green
        case "Paused":
            return .orange
        case "Stopped":
            return .gray
        default:
            return .gray
        }
    }
    
    var statusSubtext: String {
        switch videoManager.status {
        case "Playing":
            return "Playing wallpaper..."
        case "Paused":
            return "Paused"
        case "Stopped":
            return "Ready to play"
        default:
            return "Idle"
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(VideoManager())
}