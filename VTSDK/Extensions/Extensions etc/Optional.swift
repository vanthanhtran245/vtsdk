//
//  Optional.swift
//  SunflowerSDK
//
//  Created by Thanh Tran Van on 7/13/18.
//  Copyright © 2018 Sunflower. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == String {
    public var isBlank: Bool {
        return self?.isEmpty ?? true
    }
    
    public var blankIfNil: String {
        return self ?? ""
    }
}

public extension Optional where Wrapped == Any {
    public var isNil: Bool {
        return self == nil
    }
}

public extension Optional {
    
    public func filter(_ predicate: (Wrapped) -> Bool) -> Optional {
        return map(predicate) == .some(true) ? self : .none
    }
    
    public func mapNil(_ predicate: () -> Wrapped) -> Optional {
        return self ?? .some(predicate())
    }
    
    public func flatMapNil(_ predicate: () -> Optional) -> Optional {
        return self ?? predicate()
    }
    
    public func then(_ f: (Wrapped) -> Void) {
        if let wrapped = self { f(wrapped) }
    }
    
    public func maybe<U>(_ defaultValue: U, f: (Wrapped) -> U) -> U {
        return map(f) ?? defaultValue
    }
    
    public func onSome(_ f: (Wrapped) -> Void) -> Optional {
        then(f)
        return self
    }
    
    public func onNone(_ f: () -> Void) -> Optional {
        if isNone { f() }
        return self
    }
    
    public var isSome: Bool {
        return self != nil
    }
    
    public var isNone: Bool {
        return !isSome
    }
}
