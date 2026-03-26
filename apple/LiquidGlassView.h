#import <React/RCTViewComponentView.h>

#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#else
#import <UIKit/UIKit.h>
#endif

#ifndef LiquidGlassViewNativeComponent_h
#define LiquidGlassViewNativeComponent_h

NS_ASSUME_NONNULL_BEGIN

@interface LiquidGlassView : RCTViewComponentView
@end

NS_ASSUME_NONNULL_END

#endif /* LiquidGlassViewNativeComponent_h */
