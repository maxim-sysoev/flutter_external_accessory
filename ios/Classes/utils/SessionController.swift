//
//  SessionController.swift
//  flutter_external_accessory
//
//  Created by sysoev on 30.05.2022.
//

import Foundation
import ExternalAccessory

enum SessionError: Error {
    case writeError
}

class SessionController: NSObject {
    private let _session: EASession
    private let _writeData: NSMutableData = NSMutableData()
    
    public var connectionID: Int? {
        get {
            return _session.accessory?.connectionID
        }
    }
    
    init(session: EASession) {
        self._session = session
        super.init()
        
        _session.accessory?.delegate = self
        _session.inputStream?.delegate = self
        _session.inputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        _session.inputStream?.open()
        _session.outputStream?.delegate = self
        _session.outputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        _session.outputStream?.open()
    }
    
    /**
     Отправка данных на устройство
     */
    public func writeData(_ data: NSData) {
        _writeData.append(data.bytes, length: data.length);
        _sendDataToDevice();
    }
    
    public func close() {
        _session.inputStream?.close()
        _session.inputStream?.remove(from: RunLoop.current, forMode: RunLoop.Mode.default)
        _session.inputStream?.delegate = nil
        _session.outputStream?.close()
        _session.outputStream?.remove(from: RunLoop.current, forMode: RunLoop.Mode.default)
        _session.outputStream?.delegate = nil
        
        // TODO: send event to stop listen event channel with messages
    }
    
    // MARK: Internal

    // low level write method - write data to the accessory while there is space available and data to write
    private func _sendDataToDevice() {
        while ((_session.outputStream?.hasSpaceAvailable ?? false) && (_writeData.length > 0))
        {
            guard let bytesWritten = _session.outputStream?.write(
                _writeData.bytes.assumingMemoryBound(to: UInt8.self),
                maxLength: _writeData.length
            ) else {
                break
            }
            
            if (bytesWritten == -1)
            {
                NSLog("write error")
                break
            }
            else if (bytesWritten > 0)
            {
                _writeData.replaceBytes(in: NSMakeRange(0, bytesWritten), withBytes: nil, length: 0)
                NSLog("bytesWritten \(bytesWritten)")

            }
        }
    }
    
    private func _readData() {
        // TODO: todo read messages
    }
//    // low level read method - read data while there is data and space available in the input buffer
//    - (void)_readData {
//    #define EAD_INPUT_BUFFER_SIZE 128
//        uint8_t buf[EAD_INPUT_BUFFER_SIZE];
//        while ([[_session inputStream] hasBytesAvailable])
//        {
//            NSInteger bytesRead = [[_session inputStream] read:buf maxLength:EAD_INPUT_BUFFER_SIZE];
//            if (_readData == nil) {
//                _readData = [[NSMutableData alloc] init];
//            }
//            [_readData appendBytes:(void *)buf length:bytesRead];
//            NSLog(@"read %ld bytes from input stream", (long)bytesRead);
//        }
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:EADSessionDataReceivedNotification object:self userInfo:nil];
//    }

}

extension SessionController: StreamDelegate {
    internal func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch (eventCode) {
        case .openCompleted:
            break;
        case .hasBytesAvailable:
            self._readData();
            break;
        case .hasSpaceAvailable:
            self._sendDataToDevice();
            break;
        case .errorOccurred:
            break;
        case .endEncountered:
            break;
        default:
            break;
        }
    }
}

extension SessionController: EAAccessoryDelegate {
    internal func accessoryDidDisconnect(_ accessory: EAAccessory) {
        if (accessory.connectionID == _session.accessory?.connectionID) {
            close()
        }
    }
}
