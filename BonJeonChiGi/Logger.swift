//
//  Logger.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 30..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class Logger: NSObject {
    
    enum LogLevel {
        case INFO
        case DEBUG
        case WARN
        case ERROR
    }
    
    private let logPlace:String
    
    public init(logPlace:AnyClass) {
        self.logPlace = "\(logPlace)"
    }
    
    public func info(message:Any) {
        let log = stringFormat(logLevel: LogLevel.INFO, message: message)
        print(log)
    }
    
    public func debug(message:Any) {
        #if DEBUG
            let log = stringFormat(logLevel: LogLevel.DEBUG, message: message)
            print(log)
        #endif
    }
    
    public func warn(message:Any) {
        let log = stringFormat(logLevel: LogLevel.WARN, message: message)
        print(log)
    }
    
    public func error(message:Any) {
        let log = stringFormat(logLevel: LogLevel.ERROR, message: message)
        print(log)
    }
    
    private func stringFormat(logLevel:LogLevel, message:Any) -> String {
        return "[\(logLevel) - \(self.logPlace)] : \(message)"
    }
    
    
}
