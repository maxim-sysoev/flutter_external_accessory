import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_external_accessory/flutter_external_accessory_platform_interface.dart';

/// An implementation of [FlutterExternalAccessoryPlatform] that uses method channels.
class MethodChannelFlutterExternalAccessory extends FlutterExternalAccessoryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_external_accessory');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
