import 'dart:async';

import 'package:flutter_external_accessory/flutter_external_accessory_method_channel.dart';

class DeviceConnectionController {
  final int connectionId;
  final WriteData _writeData;
  // todo: receive messages
  // final _messagesStreamController = StreamController();

  DeviceConnectionController(this.connectionId, this._writeData);

  Future<void> writeData(List<int> bytes) {
    return _writeData(connectionId, bytes);
  }
}
