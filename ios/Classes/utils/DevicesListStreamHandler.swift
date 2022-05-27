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
    private var _sink: FlutterEventSink?
    
    /// Список доступных устройств
    var devicesList: Array<EAAccessory> = [];
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _sink = events
        
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        <#code#>
        _sink = nil
    }
    
    /**
     Добавить устройство в список доступных для поключения.
     
     - Parameter device: Устройство которое надо добавить.
     */
    func addDevice(_ device: EAAccessory) {
        devicesList.append(device)
    }
    
    
    /**
     Удаляет устройство из списока доступных для поключения.
     
     - Parameter device: Устройство которое надо удалить.
     */
    func removeDevice(_ device: EAAccessory) {
        devicesList.removeAll(where: { $0.connectionID == device.connectionID})
    }
}
