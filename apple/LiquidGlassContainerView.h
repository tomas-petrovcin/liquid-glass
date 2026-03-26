#import <React/RCTViewComponentView.h>

#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#else
#import <UIKit/UIKit.h>
#endif

#ifndef LiquidGlassContainerViewNativeComponent_h
#define LiquidGlassContainerViewNativeComponent_h

NS_ASSUME_NONNULL_BEGIN

@interface LiquidGlassContainerView : RCTViewComponentView
@end

NS_ASSUME_NONNULL_END

#endif /* LiquidGlassContainerViewNativeComponent_h */

