import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_external_accessory/controllers/device_connection_controller.dart';
import 'package:flutter_external_accessory/flutter_external_accessory_platform_interface.dart';
import 'package:flutter_external_accessory/models/device_model/device_model.dart';

typedef WriteData = Future<void> Function(int connectionId, List<int> bytes);

/// An implementation of [FlutterExternalAccessoryPlatform] that uses method channels.
class MethodChannelFlutterExternalAccessory extends FlutterExternalAccessoryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_external_accessory/method_channel');

  @visibleForTesting
  final devicesEventChannel = const EventChannel('flutter_external_accessory/devices_list_channel');

  @override
  Stream<List<DeviceModel>> scanDevices() {
    methodChannel.invokeMethod<void>('startScan');
    final streamController = StreamController<List<DeviceModel>>();

    final subscription = devicesEventChannel
        .receiveBroadcastStream()
        .cast<List<Object?>>()
        .map((devices) => devices
            .map((device) => DeviceModel.fromJson(Map<String, Object?>.from(device as Map)))
            .toList())
        .listen(streamController.add);

    streamController.onCancel = () {
      methodChannel.invokeMethod<void>('stopScan');
      subscription.cancel();
      streamController.close();
    };

    return streamController.stream;
  }

  @override
  Future<DeviceConnectionController> connectDevice(int connectionId, String protocol) async {
    final connection = await methodChannel.invokeMethod<int>('connect', <String, Object?>{
      'connectionId': connectionId,
      'protocol': protocol,
    });

    if (connection == null) {
      // todo: normal exception
      throw Exception();
    }

    return DeviceConnectionController(
      connection,
      writeData,
    );
  }

  @override
  @protected
  Future<void> writeData(int connectionId, List<int> bytes) {
    return methodChannel.invokeMethod<void>('write', <String, Object?>{
      'connectionId': connectionId,
      'data': bytes,
    });
  }
}
