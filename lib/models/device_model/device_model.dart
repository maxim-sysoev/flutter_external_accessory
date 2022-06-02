import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
@immutable
class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    required bool isConnected,
    required int connectionID,
    required String manufacturer,
    required String name,
    required String modelNumber,
    required String serialNumber,
    required String firmwareRevision,
    required String hardwareRevision,
    required String? macAddress,
    required List<String> protocolStrings,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => _$DeviceModelFromJson(json);
}
