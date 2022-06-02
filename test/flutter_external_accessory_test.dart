// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_external_accessory/flutter_external_accessory.dart';
// import 'package:flutter_external_accessory/flutter_external_accessory_platform_interface.dart';
// import 'package:flutter_external_accessory/flutter_external_accessory_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockFlutterExternalAccessoryPlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterExternalAccessoryPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final FlutterExternalAccessoryPlatform initialPlatform = FlutterExternalAccessoryPlatform.instance;
//
//   test('$MethodChannelFlutterExternalAccessory is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFlutterExternalAccessory>());
//   });
//
//   test('getPlatformVersion', () async {
//     FlutterExternalAccessory flutterExternalAccessoryPlugin = FlutterExternalAccessory();
//     MockFlutterExternalAccessoryPlatform fakePlatform = MockFlutterExternalAccessoryPlatform();
//     FlutterExternalAccessoryPlatform.instance = fakePlatform;
//
//     expect(await flutterExternalAccessoryPlugin.getPlatformVersion(), '42');
//   });
// }
