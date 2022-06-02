import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_external_accessory/flutter_external_accessory.dart';
import 'package:flutter_external_accessory/models/device_model/device_model.dart';
import 'package:flutter_external_accessory_example/screens/printer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription subscription;
  List<DeviceModel> _devices = [];
  final _flutterExternalAccessoryPlugin = FlutterExternalAccessory();

  @override
  void initState() {
    super.initState();
    subscription = _flutterExternalAccessoryPlugin.scanDevices().listen((event) {
      _devices = event;
      debugPrint('$event');
      setState(() {});
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView.builder(
          itemCount: _devices.length,
          itemBuilder: (context, index) => _DeviceTile(device: _devices[index]),
        ),
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final DeviceModel device;

  const _DeviceTile({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(device.toString()),
      onTap: () => _connectDevice(context),
    );
  }

  void _connectDevice(BuildContext context) async {
    const printerProtocol = 'com.datecs.printer.escpos';
    if (device.protocolStrings.contains(printerProtocol)) {
      final controller = await FlutterExternalAccessory().connect(
        device.connectionID,
        printerProtocol,
      );

      //ignore:use_build_context_synchronously
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrinterScreen(
            device: device,
            controller: controller,
          ),
        ),
      );
    }
  }
}
