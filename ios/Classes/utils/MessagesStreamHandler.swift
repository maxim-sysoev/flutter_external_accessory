//
//  MessagesStreamHandler.swift
//  flutter_external_accessory
//
//  Created by sysoev on 30.05.2022.
//

import Flutter
import Foundation
import ExternalAccessory

class MessagesStreamHandler: NSObject, FlutterStreamHandler {
    private var _sink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _sink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _sink = nil
        return nil
    }
    
    /**
     Отправляет полученное сообщение в флаттер.
     
     - Parameter message: Полученное сообщение.
     */
    public func sendeReceivedMessage(_ message: ReceivedMessage) {
        _sink?(message.toDto())
    }
}
