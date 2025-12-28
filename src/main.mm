#import <Cocoa/Cocoa.h>
#include "WallpaperEngine.hpp"

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property WallpaperEngine* engine;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    // Initialize C++ engine (wallpaper window created via C++ bridge)
    self.engine = new WallpaperEngine();
    self.engine->start();
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