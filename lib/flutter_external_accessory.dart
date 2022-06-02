import 'package:flutter_external_accessory/controllers/device_connection_controller.dart';
import 'package:flutter_external_accessory/flutter_external_accessory_platform_interface.dart';
import 'package:flutter_external_accessory/models/device_model/device_model.dart';

class FlutterExternalAccessory {
  /// Поиск устройств для подключения
  Stream<List<DeviceModel>> scanDevices() {
    return FlutterExternalAccessoryPlatform.instance.scanDevices();
  }

  /// Установить соединение с устройством
  Future<DeviceConnectionController> connect(int connectionId, String protocol) {
    return FlutterExternalAccessoryPlatform.instance.connectDevice(connectionId, protocol);
  }

  /// Отключить соединение с устройством
  Future<void> disconnect(int connectionId) {
    return FlutterExternalAccessoryPlatform.instance.disconnectDevice(connectionId);
  }
}
