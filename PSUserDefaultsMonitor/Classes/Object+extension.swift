//
//  Object+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension NSObject {
    
    internal func PS_toJsonObject() -> AnyObject {
        if self is NSArray || self is NSDictionary {
            return self.PS_toJsonObject()
        }
        
        var target:AnyObject! = self
        
        if let weakObject = self as? Weak<AnyObject> {
            target = weakObject.value
        }
        
        if target == nil {
            return NSNull()
        } else if NSJSONSerialization.isValidJSONObject(target) {
            return target
        } else {
            return target.description
        }
    }
}