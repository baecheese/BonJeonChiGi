//
//  SharedMemoryContext.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 26..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation

public enum contextKey {
    case selectId
}

public struct SharedMemoryContext {
    
    private static var context:[contextKey:Any?] = Dictionary()
    
    public static func get(key:contextKey) -> Any? {
        if context[key] == nil {
            return nil
        }
        return context[key]!
    }
    
    public static func set(key:contextKey, setValue:Any) {
        if context[key] != nil {
            changeValue(key: key, value: setValue)
            return;
        }
        context.updateValue(setValue, forKey: key)
    }
    
    public static func setAndGet(key:contextKey, setValue:Any) -> Any {
        if context[key] != nil {
            changeValue(key: key, value: setValue)
            return setValue
        }
        context.updateValue(setValue, forKey: key)
        return setValue
    }
    
    private static func changeValue(key:contextKey, value:Any) {
        context[key] = value
    }
    
}
