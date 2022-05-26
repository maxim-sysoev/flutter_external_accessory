import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_external_accessory/flutter_external_accessory_method_channel.dart';

void main() {
  MethodChannelFlutterExternalAccessory platform = MethodChannelFlutterExternalAccessory();
  const MethodChannel channel = MethodChannel('flutter_external_accessory');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
