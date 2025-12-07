#import <Cocoa/Cocoa.h>
#include "WallpaperEngine.hpp"
#include <thread>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property WallpaperEngine* engine;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    self.engine = new WallpaperEngine();
    self.engine->start();
    
    // Get bundled video path
    NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mp4"];
    if (videoPath) {
        self.engine->setVideoPath([videoPath UTF8String]);
    }
    
    // Create menu bar icon
    [self setupMenuBar];
}

- (void)setupMenuBar {
    NSStatusBar* statusBar = [NSStatusBar systemStatusBar];
    NSStatusItem* item = [statusBar statusItemWithLength:NSStatusItemLengthVariable];
    [item.button setTitle:@"🎬"];
    
    NSMenu* menu = [[NSMenu alloc] init];
    [menu addItemWithTitle:@"Quit Cool" action:@selector(quit:) keyEquivalent:@"q"];
    [item setMenu:menu];
}

- (void)quit:(id)sender {
    [NSApp terminate:nil];
}

- (void)applicationWillTerminate:(NSNotification*)notification {
    if (self.engine) {
        self.engine->stop();
        delete self.engine;
    }
}

@end

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        NSApplication* app = [NSApplication sharedApplication];
        AppDelegate* delegate = [[AppDelegate alloc] init];
        [app setDelegate:delegate];
        [app run];
    }
    return 0;
}