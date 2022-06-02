//
//  devices_list_stream_handler.swift
//  flutter_external_accessory
//
//  Created by sysoev on 27.05.2022.
//

import Flutter
import Foundation
import ExternalAccessory

/**
 Объект для хранения и отправки в Flutter данных об устройсвах, доступных к подключению.
 */
class DevicesListStreamHandler : NSObject, FlutterStreamHandler {
    /// Список доступных устройств
    public var devicesList: Array<EAAccessory> = []
    
    private var _sink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _sink = events
        _syncDevices()
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _sink = nil
        return nil
    }
    
    /**
     Проинициализировать список устройств при начале поиска.
     
     - Parameter devices: Начальный список усройтсв
     */
    public func initDevicesList(_ devices: Array<EAAccessory>) {
        devicesList = devices
        _syncDevices()
    }
    
    /**
     Очистка списка устройств при завершении поиска.
     */
    public func clearDevicesList() {
        devicesList = []
        _syncDevices()
    }
    
    /**
     Добавить устройство в список доступных для поключения.
     
     - Parameter device: Устройство которое надо добавить.
     */
    public func addDevice(_ device: EAAccessory) {
        devicesList.append(device)
        _syncDevices()
    }
    
    
    /**
     Удаляет устройство из списока доступных для поключения.
     
     - Parameter device: Устройство которое надо удалить.
     */
    public func removeDevice(_ device: EAAccessory) {
        devicesList.removeAll(where: { $0.connectionID == device.connectionID})
        _syncDevices()
    }
    
    private func _syncDevices() {
        _sink?(devicesList.map { DeviceModel.fromFramework($0).toDto()})
    }
}
