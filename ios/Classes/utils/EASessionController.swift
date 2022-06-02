//
//  EASessionController.swift
//  flutter_external_accessory
//
//  Created by sysoev on 30.05.2022.
//

import Foundation
import ExternalAccessory

public enum SessionException: String, LocalizedError {
    case ConnectionFailed = "Connection fail"
    case Rejected = "Invalid credentials, try again."
    case Unknown = "Unexpected REST-API error."
    
    public var errorDescription: String? { self.rawValue }
}

class EASessionController {
    public let session: EASession
    
    /**
     
     */
    init(_ session: EASession) {
        self.session = session
    }
}
