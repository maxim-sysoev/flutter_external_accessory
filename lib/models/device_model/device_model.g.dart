// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeviceModel _$$_DeviceModelFromJson(Map<String, dynamic> json) =>
    _$_DeviceModel(
      isConnected: json['isConnected'] as bool,
      connectionID: json['connectionID'] as int,
      manufacturer: json['manufacturer'] as String,
      name: json['name'] as String,
      modelNumber: json['modelNumber'] as String,
      serialNumber: json['serialNumber'] as String,
      firmwareRevision: json['firmwareRevision'] as String,
      hardwareRevision: json['hardwareRevision'] as String,
      macAddress: json['macAddress'] as String?,
      protocolStrings: (json['protocolStrings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_DeviceModelToJson(_$_DeviceModel instance) =>
    <String, dynamic>{
      'isConnected': instance.isConnected,
      'connectionID': instance.connectionID,
      'manufacturer': instance.manufacturer,
      'name': instance.name,
      'modelNumber': instance.modelNumber,
      'serialNumber': instance.serialNumber,
      'firmwareRevision': instance.firmwareRevision,
      'hardwareRevision': instance.hardwareRevision,
      'macAddress': instance.macAddress,
      'protocolStrings': instance.protocolStrings,
    };
