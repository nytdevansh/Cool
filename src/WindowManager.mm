#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

@interface WallpaperWindow : NSWindow
@property (strong) AVPlayer* player;
@property (strong) AVPlayerLayer* playerLayer;
@property (strong) AVPlayerLooper* looper;
@end

@implementation WallpaperWindow
@end

// C++ bridge functions
extern "C" {

void* createWallpaperWindow() {
    NSScreen* screen = [NSScreen mainScreen];
    NSRect frame = [screen frame];
    
    WallpaperWindow* window = [[WallpaperWindow alloc]
        initWithContentRect:frame
        styleMask:NSWindowStyleMaskBorderless
        backing:NSBackingStoreBuffered
        defer:NO
        screen:screen];
    
    // Desktop level magic
    [window setLevel:kCGDesktopWindowLevel];
    [window setCollectionBehavior:
        NSWindowCollectionBehaviorCanJoinAllSpaces |
        NSWindowCollectionBehaviorStationary];
    
    [window setBackgroundColor:[NSColor clearColor]];
    [window setOpaque:NO];
    [window setIgnoresMouseEvents:YES];
    
    // Setup layer
    NSView* contentView = [window contentView];
    [contentView setWantsLayer:YES];
    
    [window makeKeyAndOrderFront:nil];
    
    return (__bridge_retained void*)window;
}

void destroyWallpaperWindow(void* windowPtr) {
    if (!windowPtr) return;
    
    WallpaperWindow* window = (__bridge_transfer WallpaperWindow*)windowPtr;
    [window.player pause];
    [window close];
}

void playVideo(void* windowPtr, const char* path) {
    if (!windowPtr || !path) return;
    
    WallpaperWindow* window = (__bridge WallpaperWindow*)windowPtr;
    NSURL* videoURL = [NSURL fileURLWithPath:@(path)];
    
    AVPlayerItem* item = [AVPlayerItem playerItemWithURL:videoURL];
    AVQueuePlayer* player = [[AVQueuePlayer alloc] initWithPlayerItem:item];
    
    // Infinite loop
    window.looper = [AVPlayerLooper playerLooperWithPlayer:player templateItem:item];
    
    // Create layer
    window.playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    [window.playerLayer setFrame:[[window contentView] bounds]];
    [window.playerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    NSView* view = [window contentView];
    [[view layer] addSublayer:window.playerLayer];
    
    window.player = player;
    [player play];
}

void setVideoMuted(void* windowPtr, bool muted) {
    if (!windowPtr) return;
    
    WallpaperWindow* window = (__bridge WallpaperWindow*)windowPtr;
    [window.player setMuted:muted ? YES : NO];
}

} // extern "C"