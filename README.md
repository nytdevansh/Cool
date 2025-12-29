# 🎬 Cool — Video Wallpaper for macOS

A modern video wallpaper engine for macOS that plays videos behind your desktop icons.

Built with C++, Swift, Objective-C++ bridges, and CMake.

---

## ✨ Features

- ✅ Plays video behind desktop icons (proper desktop level)
- ✅ Infinite looping with AVFoundation
- ✅ Menu bar control
- ✅ Works across all spaces
- ✅ Minimal CPU usage
- ✅ Pure C++ engine with Objective-C++ macOS bridges

---

## 🏗️ Project Structure

```
Cool/
├── CMakeLists.txt                 # Build configuration
├── src/
│   ├── WallpaperEngine.hpp        # C++ engine header
│   ├── WallpaperEngine.cpp        # C++ engine implementation
│   ├── WindowManager.mm           # Obj-C++ Cocoa/AVFoundation bridge
│   ├── main.mm                    # App entry point (Obj-C++)
│   ├── CoolApp.swift              # SwiftUI app entry point
│   ├── ContentView.swift          # Main UI (SwiftUI)
│   ├── CppBridge.swift            # C++ to Swift bridge
│   └── VideoManager.swift         # Video management logic
├── Cool_web/                      # Web resources (optional)
│   ├── index.html
│   ├── script.js
│   └── style.css
├── build/                         # Build artifacts
├── Info.plist                     # App bundle metadata
├── Cool.entitlements              # Security entitlements
└── README.md                      # You are here
```

---

## 🔧 Requirements

- macOS 11.0+ (Big Sur or later)
- Xcode Command Line Tools
- CMake 3.20+
- A video file (MP4, MOV)

---

## 🚀 Build Instructions

### 1. Install Dependencies

```bash
# Install Xcode Command Line Tools (if not already)
xcode-select --install

# Install CMake (via Homebrew)
brew install cmake
```

### 2. Build

```bash
# Using provided build script (recommended)
./build.sh

# Or manually:
mkdir -p build && cd build
cmake ..
make
```

### 3. Run

```bash
# Open the compiled app
open Cool.app

# Or from build directory
open build/Release/Cool.app
```

---

## 🎮 Usage

### Running th and launching:
1. The app appears in the menu bar
2. Select a video file via the UI
3. Video plays behind your desktop icons on repeat
4. Video loops infinitely without gaps

### Controls

- Select video from file picker
- Pause/Resume playback
- Mute toggle
- Adjust scaling mode (Fill/Fit/Stretch)
- Quit from menu bar
Click the 🎬 icon in the menu bar:
- **Quit Cool** — Stop the app

---Modify Video Selection UI

Edit `src/ContentView.swift` to customize the video picker interface and add new controls.

### Add Scaling Modes

Current modes are defined in `src/VideoManager.swift`.

To add more scaling options:
1. Add enum case in `VideoManager`
2. Implement corresponding `AVLayerVideoGravity` in `WindowManager.mm`
3. Update SwiftUI controls in `ContentView.swift`

### Multi-Monitor Support

Modify `createWallpaperWindow()` in `src/WindowManager.mm` to loop through `[NSScreen screens]` and create wallpaper layers for each display

### Multi-Monitor Support

To add multiple displays, modify `createWallpaperWindow()` in `WindowManager.mm` to loop through `[NSScreen screens]`.

---

## 🧩 Architecture

### C++ Core (`WallpaperEngine`)
- Pure C++ engine logic
- Platform-agnostic interface
- Staore Components

**WallpaperEngine (C++)**
- Engine logic and state management
- Platform-agnostic implementation
- Handles wallpaper layer management

**WindowManager (Objective-C++)**
- Cocoa window creation at desktop level
- AVFoundation video playback
- Bridges between C++ core and Cocoa/AVFoundation

**Swift UI Layer**
- `CoolApp.swift` — SwiftUI app entry point
- `ContentView.swift` — Main UI for controls
- `VideoManager.swift` — Swift video management
- `CppBridge.swift` — C++/Swift interoperability

### Communication Flow
```
User → ContentView (SwiftUI)
  ↓
VideoManager (Swift)
  ↓
CppBridge (Obj-C++ bridge)
  ↓
WallpaperEngine (C++)
  ↓
WindowManager (Obj-C++ → Cocoa/AVFoundation)
```
## ⚙️ Technical Details

### Desktop Level Window

```objc
[window setLevel:kCGDesktopWindowLevel];
```

This places the window **below** desktop icons but **above** the actual desktop wallpaper.

### Infinite Looping

```objc
AVPlBuild fails with CMake errors
```bash
# Clean build from scratch
rm -rf build/
mkdir build && cd build
cmake ..
make
```

### "The application cannot be opened"
- Ensure build completed successfully: `ls build/Release/Cool.app/Contents/MacOS/Cool`
- Check code signing: `codesign -v build/Release/Cool.app`

### Video not displaying
- Verify video codec (H.264/HEVC recommended)
- Check file permissions: `ls -la /path/to/video.mp4`
- Ensure video format is supported by AVFoundation

### Swift/Objective-C++ interop issues
- Verify bridge declarations in `CppBridge.swift`
- Check `WindowManager.mm` properly exposes C++ interfaces
- Ensure proper `#include` directives in bridge files

### Performance/CPU high
- Check window level setting in `WindowManager.mm`
- Verify video resolution matches display
- Profile with Instruments.app
## 🐛 Common Issues

### "The application cannot be opened because its executable is missing"
- Run `make` successfully first
- Check that `Cool.app/Contents/MacOS/Cool` exists

### Video not showing
- Ensure `sample.mp4` is in `resources/` folder
- Check CMake copied it: `ls Cool.app/Contents/Resources/`
- Verify video codec (H.264 recommended)

### Linker errors about duplicate symbols
- Delete `src/VideoPlayer.mm` if it exists (duplicate of `WindowManager.mm`)
- Clean build: `rm -rf build/* && cd build && cmake .. && make`

### Compiler warnings about `__bridge_retained`
- Enable ARC in CMakeLists.txt: `set(CMAKE_OBJCXX_FLAGS "${CMAKE_OBJCXX_FLAGS} -fobjc-arc")`
- Or ignore them (they're warnings, not errors)

---

## 🗺️ Roadmap

### Phase 1 — Foundations ✅
- [x] Basic window at desktop level
- [x] Video playback with looping
- [x] Bundled app
- [x] C++/Swift/Objective-C++ architecture

### Phase 2 — Core Features (In Progress)
- [x] File picker to choose videos
- [x] Pause/Resume controls
- [ ] Mute toggle
- [ ] Scaling mode selector (Fill/Fit/Stretch)
- [ ] UserDefaults to remember last video

### Phase 3 — Polish
- [ ] Multi-monitor support
- [ ] Auto-start at login
- [ ] CPU/battery saver mode
- [ ] Performance profiling
- [ ] Native app preferences window

### Phase 4 — Pro Features
- [ ] Per-display video settings
- [ ] Playlist support
- [ ] Video preview thumbnails
- [ ] Screen detection (pause during games)
- [ ] HEVC/webM/VP9 codec support
- [ ] Brightness/contrast adjustment
- [ ] Schedule wallpaper changes

---

## 📜 License

MIT License — Do whatever you want with this code.

Just don't blame me if your Mac catches fire trying to play 8K 120fps videos as a wallpaper.

---

## 🙏 Credits

Built with a hybrid approach: C++ for performance, Swift for modern UI, and Objective-C++ for the macOS bridge.

Inspired by the need for a lightweight, customizable video wallpaper solution on macOS.

---

## 💬 Contributing

Found a bug? Want to add a feature?

1. Fork it
2. Fix it
3. Submit a PR

Or just roast me in the issues tab. Either works.

---

**Now go add your own video and make your desktop cool.** 🎬