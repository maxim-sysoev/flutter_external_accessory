//
//  ReceivedMessage.swift
//  flutter_external_accessory
//
//  Created by sysoev on 30.05.2022.
//

import Foundation

/**
 Данные полученные с устройства. Идентификация устройства отправившего сообщение происходит по  id девайса.
 */
class ReceivedMessage {
    let data: NSData
    let connectionId: Int
    
    init(data: NSData, connectionId: Int) {
        self.data = data
        self.connectionId = connectionId
    }
    
    public func toDto() -> [String: Any] {
        return [
            "data" : data,
            "connectionId" : connectionId,
        ]
    }
}
