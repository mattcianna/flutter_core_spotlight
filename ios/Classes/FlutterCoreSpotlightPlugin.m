#import "FlutterCoreSpotlightPlugin.h"
#if __has_include(<flutter_core_spotlight/flutter_core_spotlight-Swift.h>)
#import <flutter_core_spotlight/flutter_core_spotlight-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_core_spotlight-Swift.h"
#endif

@import CoreSpotlight;
@import MobileCoreServices;

@implementation FlutterCoreSpotlightPlugin

NSString *kPluginName = @"flutter_core_spotlight";

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
                                   methodChannelWithName:kPluginName
                                   binaryMessenger:[registrar messenger]];
  [SwiftFlutterCoreSpotlightPlugin registerWithRegistrar:registrar];
}

@end
