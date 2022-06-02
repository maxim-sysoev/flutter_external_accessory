//
//  DeviceModel.swift
//  flutter_external_accessory
//
//  Created by sysoev on 28.05.2022.
//

import Foundation
import ExternalAccessory

/// Модель данных для подключенного устройства
class DeviceModel {
    public let isConnected: Bool
    public let connectionID: Int
    public let manufacturer: String
    public let name: String
    public let modelNumber: String
    public let serialNumber: String
    public let firmwareRevision: String
    public let hardwareRevision: String
    public let macAddress: String?
    
    /// Array of strings representing the protocols supported by the accessory.
    public let protocolStrings: [String]
    
    init(isConnected: Bool,
         connectionID: Int,
         manufacturer: String,
         name: String,
         modelNumber: String,
         serialNumber: String,
         firmwareRevision: String,
         hardwareRevision: String,
         macAddress: String?,
         protocolStrings: [String]) {
        self.isConnected = isConnected
        self.connectionID = connectionID
        self.manufacturer = manufacturer
        self.name = name
        self.modelNumber = modelNumber
        self.serialNumber = serialNumber
        self.firmwareRevision = firmwareRevision
        self.hardwareRevision = hardwareRevision
        self.macAddress = macAddress
        self.protocolStrings = protocolStrings
    }
    
    public static func fromFramework (_ device: EAAccessory) -> DeviceModel {
        return DeviceModel(isConnected: device.isConnected,
                           connectionID: device.connectionID,
                           manufacturer: device.manufacturer,
                           name: device.name,
                           modelNumber: device.modelNumber,
                           serialNumber: device.serialNumber,
                           firmwareRevision: device.firmwareRevision,
                           hardwareRevision: device.hardwareRevision,
                           macAddress: device.value(forKey: "macAddress") as! String?,
                           protocolStrings: device.protocolStrings)
    }
    
    public func toDto() -> [String : Any?] {
        return [
            "isConnected": isConnected,
            "connectionID": connectionID,
            "manufacturer": manufacturer,
            "name": name,
            "modelNumber": modelNumber,
            "serialNumber": serialNumber,
            "firmwareRevision": firmwareRevision,
            "hardwareRevision": hardwareRevision,
            "macAddress": macAddress,
            "protocolStrings": protocolStrings
        ]
    }
}
