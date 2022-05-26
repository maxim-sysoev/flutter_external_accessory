import 'package:flutter_external_accessory/flutter_external_accessory_platform_interface.dart';

class FlutterExternalAccessory {
  Future<String?> getPlatformVersion() {
    return FlutterExternalAccessoryPlatform.instance.getPlatformVersion();
  }
}
