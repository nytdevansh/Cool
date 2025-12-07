# 🎬 Cool — Video Wallpaper for macOS

A lightweight, C++-powered video wallpaper engine for macOS that plays videos behind your desktop icons.

Built with pure C++, Objective-C++ bridges, and zero Swift drama.

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
├── CMakeLists.txt          # Build configuration
├── src/
│   ├── main.mm             # App entry point (Obj-C++)
│   ├── WallpaperEngine.hpp # C++ engine header
│   ├── WallpaperEngine.cpp # C++ engine implementation
│   └── WindowManager.mm    # Obj-C++ bridge to Cocoa/AVFoundation
├── resources/
│   └── sample.mp4          # Test video (add your own)
├── Info.plist              # App bundle metadata
├── Cool.entitlements       # Security entitlements
└── README.md               # You are here
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

### 2. Add Your Video

Place a video file named `sample.mp4` in the `resources/` folder.

### 3. Build

```bash
# Create build directory
mkdir build && cd build

# Configure
cmake ..

# Build
make

# Run
open Cool.app
```

---

## 🎮 Usage

### Running the App

After building, the app will:
1. Launch in the menu bar (look for 🎬 icon)
2. Automatically play the bundled video behind your desktop icons
3. Video loops infinitely

### Menu Bar Controls

Click the 🎬 icon in the menu bar:
- **Quit Cool** — Stop the app

---

## 🛠️ Customization

### Change Video

Edit `src/main.mm` line 13:

```objc
NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mp4"];
```

Change `@"sample"` to your video filename (without extension).

### Add Scaling Modes

Currently supports `AVLayerVideoGravityResizeAspectFill` (fill screen).

To add more modes, implement `WallpaperEngine::setScaleMode()` in `WallpaperEngine.cpp`.

### Multi-Monitor Support

To add multiple displays, modify `createWallpaperWindow()` in `WindowManager.mm` to loop through `[NSScreen screens]`.

---

## 🧩 Architecture

### C++ Core (`WallpaperEngine`)
- Pure C++ engine logic
- Platform-agnostic interface
- State management

### Objective-C++ Bridges
- `WindowManager.mm` — Cocoa window creation, AVFoundation playback
- `main.mm` — App lifecycle, menu bar UI

### Communication
- C++ calls Objective-C++ functions via `extern "C"` bridges
- Objective-C++ uses `void*` handles to pass objects back to C++

---

## ⚙️ Technical Details

### Desktop Level Window

```objc
[window setLevel:kCGDesktopWindowLevel];
```

This places the window **below** desktop icons but **above** the actual desktop wallpaper.

### Infinite Looping

```objc
AVPlayerLooper* looper = [AVPlayerLooper playerLooperWithPlayer:player 
                                                   templateItem:item];
```

AVFoundation's built-in looper prevents gaps between loops.

### Ignoring Mouse Events

```objc
[window setIgnoresMouseEvents:YES];
```

Allows clicking through the video to interact with desktop icons.

---

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
- [x] Menu bar UI
- [x] Bundled video support

### Phase 2 — Control UI
- [ ] File picker to choose videos
- [ ] UserDefaults to remember last video
- [ ] Pause/Resume controls
- [ ] Mute toggle
- [ ] Scaling mode selector (Fill/Fit/Stretch)

### Phase 3 — Polish
- [ ] Multi-monitor support
- [ ] Auto-start at login
- [ ] CPU/battery saver mode
- [ ] Performance profiling

### Phase 4 — Pro Features
- [ ] Per-display video settings
- [ ] Playlist support
- [ ] Video preview thumbnails
- [ ] Screen detection (pause during games)
- [ ] HEVC/webM codec support

---

## 📜 License

MIT License — Do whatever you want with this code.

Just don't blame me if your Mac catches fire trying to play 8K 120fps videos as a wallpaper.

---

## 🙏 Credits

Built by someone who refused to use Swift and insisted on doing it the hard way with C++.

Inspired by every unfinished project in `~/Desktop/old_projects/`.

---

## 💬 Contributing

Found a bug? Want to add a feature?

1. Fork it
2. Fix it
3. Submit a PR

Or just roast me in the issues tab. Either works.

---

**Now go add your own video and make your desktop cool.** 🎬