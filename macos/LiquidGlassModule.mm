#import <Foundation/Foundation.h>
#import "LiquidGlassModule.h"

@implementation LiquidGlassModule {
  facebook::react::ModuleConstants<JS::NativeLiquidGlassModule::Constants> _constants;
}

- (void)initialize
{
  // For macOS, mark unsupported for now. You can enhance when macOS glass APIs are available.
  _constants = facebook::react::typedConstants<JS::NativeLiquidGlassModule::Constants>({
    .isLiquidGlassSupported = NO
  });
}

- (facebook::react::ModuleConstants<JS::NativeLiquidGlassModule::Constants>)constantsToExport
{
  return (facebook::react::ModuleConstants<JS::NativeLiquidGlassModule::Constants>)[self getConstants];
}

+ (NSString *)moduleName {
  return @"NativeLiquidGlassModule";
}

- (facebook::react::ModuleConstants<JS::NativeLiquidGlassModule::Constants>)getConstants
{
  return _constants;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeLiquidGlassModuleSpecJSI>(params);
}

@end
