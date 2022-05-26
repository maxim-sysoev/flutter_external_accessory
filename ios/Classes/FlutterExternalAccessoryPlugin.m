#import "FlutterExternalAccessoryPlugin.h"
#if __has_include(<flutter_external_accessory/flutter_external_accessory-Swift.h>)
#import <flutter_external_accessory/flutter_external_accessory-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_external_accessory-Swift.h"
#endif

@implementation FlutterExternalAccessoryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterExternalAccessoryPlugin registerWithRegistrar:registrar];
}
@end
