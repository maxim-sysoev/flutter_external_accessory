import 'dart:typed_data';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_external_accessory/controllers/device_connection_controller.dart';
import 'package:flutter_external_accessory/models/device_model/device_model.dart';
import 'package:image/image.dart' as img;

class PrinterScreen extends StatefulWidget {
  const PrinterScreen({
    required this.device,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final DeviceModel device;
  final DeviceConnectionController controller;

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(widget.device.toString()),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _testPrint,
            child: const Text('test print'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _printImage,
            child: const Text('Print image'),
          ),
        ],
      ),
    );
  }

  Future<void> _testPrint() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text('Hello world!');
    bytes += generator.feed(2);

    widget.controller.writeData(bytes);

    // bytes += generator.text(
    //     'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ');
    // bytes += generator.text('Special 2: blåbærgrød');
    //
    // bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    // bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    // bytes += generator.text('Underlined text', styles: PosStyles(underline: true), linesAfter: 1);
    // bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    // bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    // bytes += generator.text('Align right', styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.text('Scale not works. Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size8,
        ));

    bytes += generator.feed(3);

    debugPrint('length: ${bytes.length}\nbytes: $bytes\n');

    widget.controller.writeData(bytes);
  }

  Future<void> _printImage() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    final ByteData data = await rootBundle.load('assets/mfg_logo.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final img.Image? image = img.decodeImage(bytes);
    // Using `ESC *`
    var generatedBytes = generator.image(image!);
    // Using `GS v 0` (obsolete)
    // var generatedBytes = generator.imageRaster(image!);
    // Using `GS ( L`
    // generator.imageRaster(image, imageFn: PosImageFn.graphics);
    generatedBytes += generator.feed(4);
    widget.controller.writeData(generatedBytes);
  }
}
