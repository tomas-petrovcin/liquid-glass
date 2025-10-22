#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#else
#import <UIKit/UIKit.h>
#endif

#import <React/RCTBridge.h>
#import <LiquidGlassViewSpec/LiquidGlassViewSpec.h>

@interface LiquidGlassModule : NSObject <NativeLiquidGlassModuleSpec>

@end

