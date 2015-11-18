//
//  Array+path.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/13.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension NSArray {
    
    internal func PS_valueForArrayPath(path:String, separator:String) -> AnyObject! {
        
        var onePath = path
        
        let range = path.rangeOfString(separator)
        
        var result:AnyObject!
        
        if let location = range {
            onePath = path.substringToIndex(location.startIndex)
            if let index = Int(onePath) {
                if let children = self[index] as? NSDictionary {
                    result = children.PS_valueForDictionaryPath(path.substringFromIndex(location.startIndex.successor()), separator:separator)
                } else if let children = self[index] as? NSArray {
                    result = children.PS_valueForArrayPath(path.substringFromIndex(location.startIndex.successor()), separator:separator)
                }
            }
        } else {
            if let index = Int(onePath) {
                result = self[index]
            }
        }
        return result
    }
    
}