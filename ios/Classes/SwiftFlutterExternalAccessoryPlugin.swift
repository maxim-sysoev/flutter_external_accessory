import Flutter
import UIKit
import ExternalAccessory

public class SwiftFlutterExternalAccessoryPlugin: NSObject, FlutterPlugin {
    private static let methodChannel = "flutter_external_accessory/method_channel"
    private static let devicesListChannel = "flutter_external_accessory/devices_list_channel"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: methodChannel, binaryMessenger: registrar.messenger())
        let devicesChannel = FlutterEventChannel(name: devicesListChannel, binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterExternalAccessoryPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
//        registrar.
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "initialize":
            initializePlugin()
            result(nil)
            break
            
        case "dispose":
            dispose()
            result(nil)
            break
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /**
     Инициализация плагина.
     Запускает поиск устройств, устанавливает обработчики событий подключения устройств.
     */
    public func initializePlugin() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(_accessoryDidConnect),
                                               name: NSNotification.Name.EAAccessoryDidConnect,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(_accessoryDidDisconnect),
                                               name: NSNotification.Name.EAAccessoryDidDisconnect,
                                               object: nil)
        
        EAAccessoryManager.shared().registerForLocalNotifications()
        
        
        //        _eaSessionController = [EADSessionController sharedController];
        _accessoryList = EAAccessoryManager.shared().connectedAccessories
    }
    
    /**
     Завершение работы плагина.
     Завершает поиск устройств, удаляет обработчики событий, завершает активные соединения.
     */
    public func dispose() {
        EAAccessoryManager.shared().unregisterForLocalNotifications()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.EAAccessoryDidConnect, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.EAAccessoryDidDisconnect, object: nil)
        
        _accessoryList = [];
        
        // TODO: disconnect connected devices
    }
    
    /// Список доступных устройств
    private var _accessoryList: Array<EAAccessory> = [];
    
    
    /**
     Функция обработки события подключения устройства. Добавляет девайс в список доступных.
     
     События возникает когда устройтсво вклюяается или появленися в радиусе действия bluetooth.
     
     - Parameter notification: Объект события который содержит внутри информацию о девайсе.
     */
    @objc private func _accessoryDidConnect(_ notification: NSNotification) {
        guard let connectedAccessory = (notification.userInfo?[EAAccessoryKey]) as? EAAccessory else {
            return
        }
        
        _accessoryList.append(connectedAccessory)
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
        
        _accessoryList.removeAll { item in
            return item.connectionID == disconnectedAccessory.connectionID;
        }
    }
}
