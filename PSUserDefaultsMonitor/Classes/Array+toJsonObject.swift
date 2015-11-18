//
//  Array+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension NSArray {
    
    internal override func PS_doJSonObject(objectSet objectSet: NSMutableSet!) -> AnyObject {
        
        var result = [AnyObject](count: self.count, repeatedValue: 0)
        for (index, value) in self.enumerate() {
            if let obj = value as? NSObject {
                result[index] = obj.PS_toJsonObject(objectSet:objectSet)
            } else {
                result[index] = value.description
            }
        }
        
        return result
    }
}