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
        // for checking cyclic reference.
        var objectSet = NSMutableSet()
        return self.PS_toJsonObject(objectSet:objectSet)
    }
    
    internal func PS_toJsonObject(# objectSet:NSMutableSet!) -> AnyObject {
        
        var target:AnyObject! = self
        if let weakObject = self as? Weak<AnyObject> {
            target = weakObject.value
        }
        
        if target == nil {
           return NSNull()
        }
        
        if( objectSet.containsObject(target) ) {
            return target.description
        }
        objectSet.addObject(target)
        
        if let obj = target as? NSObject {
            return obj.PS_doJSonObject(objectSet: objectSet)
        } else {
            return target.description
        }
    }
    
    internal func PS_doJSonObject(# objectSet:NSMutableSet!) -> AnyObject {
    
        if NSJSONSerialization.isValidJSONObject(self) {
            return self
        } else {
            return self.description
        }
    }
    
    

}