#import "LiquidGlassView.h"

#import <react/renderer/components/LiquidGlassViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/LiquidGlassViewSpec/EventEmitters.h>
#import <react/renderer/components/LiquidGlassViewSpec/Props.h>
#import <react/renderer/components/LiquidGlassViewSpec/RCTComponentViewHelpers.h>
#import "RCTImagePrimitivesConversions.h"

#import "RCTFabricComponentsPlugins.h"
#import "RCTConversions.h"

#if __has_include("LiquidGlass/LiquidGlass-Swift.h")
#import "LiquidGlass/LiquidGlass-Swift.h"
#else
#import "LiquidGlass-Swift.h"
#endif

using namespace facebook::react;

@interface LiquidGlassView () <RCTLiquidGlassViewViewProtocol>
@end

@implementation LiquidGlassView {
  LiquidGlassViewImpl * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<LiquidGlassViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const LiquidGlassViewProps>();
    _props = defaultProps;

    _view = [[LiquidGlassViewImpl alloc] init];

    self.contentView = _view;
  }

  return self;
}

- (void)layout
{
  [super layout];
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<LiquidGlassViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<LiquidGlassViewProps const>(props);
  BOOL needsSetup = NO;

  if (oldViewProps.tintColor != newViewProps.tintColor) {
    // NSVisualEffectView has no direct tint; store on impl if needed
    _view.effectTintColor = RCTUIColorFromSharedColor(newViewProps.tintColor);
    needsSetup = YES;
  }

  if (oldViewProps.effect != newViewProps.effect) {
    switch (newViewProps.effect) {
      case LiquidGlassViewEffect::Regular:
        [_view setStyle:LiquidGlassEffectRegular];
        break;
      case LiquidGlassViewEffect::Clear:
        [_view setStyle:LiquidGlassEffectClear];
        break;
      case LiquidGlassViewEffect::None:
        [_view setStyle:LiquidGlassEffectNone];
        break;
    }
    needsSetup = YES;
  }

  if (oldViewProps.interactive != newViewProps.interactive) {
    _view.interactive = newViewProps.interactive;
    needsSetup = YES;
  }

  if (needsSetup) {
    [_view setupView];
  }

  [super updateProps:props oldProps:oldProps];
}

- (void)updateLayoutMetrics:(const LayoutMetrics &)layoutMetrics
           oldLayoutMetrics:(const LayoutMetrics &)oldLayoutMetrics
{
  [super updateLayoutMetrics:layoutMetrics oldLayoutMetrics:oldLayoutMetrics];

  [_view setFrame:RCTCGRectFromRect(layoutMetrics.getPaddingFrame())];
}

- (void)mountChildComponentView:(NSView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index {
  [_view.contentView addSubview:childComponentView positioned:NSWindowAbove relativeTo:nil];
}

- (void)unmountChildComponentView:(NSView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index {
  [childComponentView removeFromSuperview];
}

@end
