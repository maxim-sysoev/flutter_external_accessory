import 'package:flutter/foundation.dart';
import 'package:flutter_external_accessory/controllers/device_connection_controller.dart';
import 'package:flutter_external_accessory/flutter_external_accessory_method_channel.dart';
import 'package:flutter_external_accessory/models/device_model/device_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FlutterExternalAccessoryPlatform extends PlatformInterface {
  static final Object _token = Object();

  static FlutterExternalAccessoryPlatform _instance = MethodChannelFlutterExternalAccessory();

  /// The default instance of [FlutterExternalAccessoryPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterExternalAccessory].
  static FlutterExternalAccessoryPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterExternalAccessoryPlatform] when
  /// they register themselves.
  static set instance(FlutterExternalAccessoryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Constructs a FlutterExternalAccessoryPlatform.
  FlutterExternalAccessoryPlatform() : super(token: _token);

  /// Поиск устройств для подключения
  Stream<List<DeviceModel>> scanDevices();

  Future<DeviceConnectionController> connectDevice(int connectionId, String protocol);

  @protected
  Future<void> writeData(int connectionId, List<int> bytes);
}
