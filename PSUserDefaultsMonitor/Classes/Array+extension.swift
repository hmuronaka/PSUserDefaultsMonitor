//
//  Array+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension NSArray {
    
    internal func PS_valueForArrayPath(path:String, separator:String) -> AnyObject! {
    
        var onePath = path
    
        var range = path.rangeOfString(separator)
        
        var result:AnyObject!
    
        if let location = range {
            onePath = path.substringToIndex(location.startIndex)
            if let index = onePath.toInt() {
                if let children = self[index] as? NSDictionary {
                    result = children.PS_valueForDictionaryPath(path.substringFromIndex(location.startIndex.successor()), separator:separator)
                } else if let children = self[index] as? NSArray {
                    result = children.PS_valueForArrayPath(path.substringFromIndex(location.startIndex.successor()), separator:separator)
                }
            }
        } else {
            if let index = onePath.toInt() {
                result = self[index]
            }
        }
        return result
    }
    
    internal override func PS_toJsonObject() -> AnyObject {
        
        var result = [AnyObject](count: self.count, repeatedValue: 0)
        for (index, value) in enumerate(self) {
            result[index] = value.PS_toJsonObject()
        }
        
        return result
    }
}