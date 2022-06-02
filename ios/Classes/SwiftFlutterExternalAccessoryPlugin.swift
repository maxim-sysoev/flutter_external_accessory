import Flutter
import UIKit
import ExternalAccessory

public class SwiftFlutterExternalAccessoryPlugin: NSObject, FlutterPlugin {
    private static let _methodChannel = "flutter_external_accessory/method_channel"
    private static let _devicesListChannel = "flutter_external_accessory/devices_list_channel"
    private static let _messagesChannel = "flutter_external_accessory/messages_channel"
    
    /// Контроллер EventCannel'а для передачи найденных устройств
    private let _devicesStreamHandler = DevicesListStreamHandler()
    
    /// Контроллер EventCannel'а для передачи полученных сообщений с устроств
    private let _messagesStreamHandler = MessagesStreamHandler()
    
    /// Список активных сессий
    private var _sessions: Array<SessionController> = []
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: _methodChannel, binaryMessenger: registrar.messenger())
        let devicesChannel = FlutterEventChannel(name: _devicesListChannel, binaryMessenger: registrar.messenger())
        let messagesChannel = FlutterEventChannel(name: _messagesChannel, binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterExternalAccessoryPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        devicesChannel.setStreamHandler(instance._devicesStreamHandler)
        messagesChannel.setStreamHandler(instance._messagesStreamHandler)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "startScan":
            startScanForDevices()
            result(nil)
            break
            
        case "stopScan":
            stopScanForDevices()
            result(nil)
            break
            
        case "connect":
            connectToDevice(call, result: result)
            break
            
        case "write":
            sendDataToDevice(call, result: result)
            break
            
        case "disconnet":
            result(nil)
            break
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /**
     Инициализация поиска.
     Запускает поиск устройств, устанавливает обработчики событий подключения устройств.
     */
    public func startScanForDevices() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(_accessoryDidConnect),
                                               name: NSNotification.Name.EAAccessoryDidConnect,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(_accessoryDidDisconnect),
                                               name: NSNotification.Name.EAAccessoryDidDisconnect,
                                               object: nil)
        
        EAAccessoryManager.shared().registerForLocalNotifications()
        
        _devicesStreamHandler.initDevicesList(EAAccessoryManager.shared().connectedAccessories)
    }
    
    /**
     Завершение поиска.
     Завершает поиск устройств, удаляет обработчики событий, завершает активные соединения.
     */
    public func stopScanForDevices() {
        EAAccessoryManager.shared().unregisterForLocalNotifications()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.EAAccessoryDidConnect, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.EAAccessoryDidDisconnect, object: nil)
        
        _devicesStreamHandler.clearDevicesList()
        
        // TODO: disconnect connected devices, mb not needed
    }
    
    /**
     Подключение к устройтсву для создания сессии.
     */
    public func connectToDevice(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any],
              let connectionId = arguments["connectionId"] as? Int,
              let protocolString = arguments["protocol"] as? String else {
                  result(FlutterError(code: "ARGUMENTS_ERROR", message: "Provide all arguments", details: nil))
                  return
              }
        
        let accessories = EAAccessoryManager.shared().connectedAccessories
        guard let accessory = accessories.first(where: {$0.connectionID == connectionId}) else {
            result(FlutterError(code: "CONNECTION_ERROR", message: "Can't connect to device cause it not found", details: nil))
            return
        }
        
        guard let session = EASession.init(accessory: accessory, forProtocol: protocolString) else {
            result(FlutterError(code: "CONNECTION_ERROR", message: "Session creation failed", details: nil))
            return
        }
        
        let controller = SessionController(session: session)
        _sessions.append(controller)
        
        result(session.accessory?.connectionID)
    }
    
    /**
     Подключение к устройтсву для создания сессии.
     */
    public func sendDataToDevice(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any],
              let connectionId = arguments["connectionId"] as? Int,
              let data = arguments["data"] as? [Int] else {
                  result(FlutterError(code: "ARGUMENTS_ERROR", message: "Provide all arguments", details: nil))
                  return
              }
        
        guard let controller = _sessions.first(where: {$0.connectionID == connectionId}) else {
            result(FlutterError(code: "SESSION_ERROR", message: "Can't active session with connection id = \(connectionId)", details: nil))
            return
        }
        
        
        
        let nsData = NSData.init(bytes: data.map{ val -> UInt8 in UInt8(val)}, length: data.count)
        controller.writeData(nsData)
        
        result(nil)
    }
    
    /**
     Функция обработки события подключения устройства. Добавляет девайс в список доступных.
     
     События возникает когда устройтсво вклюяается или появленися в радиусе действия bluetooth.
     
     - Parameter notification: Объект события который содержит внутри информацию о девайсе.
     */
    @objc private func _accessoryDidConnect(_ notification: NSNotification) {
        guard let connectedAccessory = (notification.userInfo?[EAAccessoryKey]) as? EAAccessory else {
            return
        }
        
        _devicesStreamHandler.addDevice(connectedAccessory)
        NSLog("connected accessory mac address: \(String(describing: connectedAccessory.value(forKey: "macAddress") as? String? ?? "no"))")
        NSLog("%@", connectedAccessory);
    }
    
    /**
     Функция обработки события отключения устройства. Удаляет девайс из списка доступных и разрывает соединени, если оно было установлено.
     
     События возникает когда устройтсво выключается или выходит за радиус действия bluetooth.
     
     - Parameter notification: Объект события который содержит внутри информацию о девайсе.
     */
    @objc private func _accessoryDidDisconnect(notification: NSNotification) {
        
        guard let disconnectedAccessory = (notification.userInfo?[EAAccessoryKey]) as? EAAccessory else {
            return
        }
        
        // TODO: if disconnected accessory was connected, then needs drop connection
        
        _devicesStreamHandler.removeDevice(disconnectedAccessory)
    }
}
