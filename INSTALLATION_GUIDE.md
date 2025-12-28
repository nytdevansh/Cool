# Cool - Video Wallpaper Engine
## Distribution Guide

---

## For End Users (Installing on Another Mac)

### Quick Installation (2 minutes)

1. **Download** `Cool.dmg` from this repository
2. **Double-click** the DMG file
3. **Drag** the Cool app icon to the Applications folder
4. **Eject** the DMG (drag to trash)
5. **Open** Cool from Applications or Spotlight (⌘Space, type "Cool")

### First Launch
- On first run, you may see a security warning
- Click **"Open"** to confirm
- The app will create a floating window for video wallpaper selection

### Usage
1. Click **"Upload Video"** to select an MP4 or video file
2. Click **Play** to set it as your wallpaper
3. Use **Pause/Stop** to control playback
4. Close the window or use **Quit** (⌘Q) to exit

---

## System Requirements

- **macOS 11** (Big Sur) or later
- **Apple Silicon** or **Intel** Mac
- **No installation fees** — completely free

---

## Troubleshooting

### App Won't Open
```bash
# Remove security restrictions (open Terminal and paste)
xattr -d com.apple.quarantine /Applications/Cool.app
```

### Video Not Showing
- Ensure video file is in a supported format (MP4, MOV, etc.)
- Check that file is readable (not corrupted)
- Try a different video file to test

### Permission Issues
- System Settings → Privacy & Security → Files and Folders
- Grant Cool access to your video files

---

## Uninstall

Simply drag `Cool.app` from Applications folder to Trash.

---

## Support

For issues or feature requests, report them on GitHub.

---

**Enjoy your video wallpapers!** 🎬

Made with C++ (AVFoundation), Objective-C++, and SwiftUI.
