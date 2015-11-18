//
//  Dictionary+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by MuronakaHiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension NSDictionary {
    
    internal override func PS_doJSonObject(objectSet objectSet: NSMutableSet!) -> AnyObject {
        return self.PS_toJsonObjectImpl(self as [NSObject:AnyObject], objectSet:objectSet)
    }

    private func PS_toJsonObjectImpl(dictionary:[NSObject:AnyObject], objectSet:NSMutableSet) -> [NSObject:AnyObject] {
        
        var result = [NSObject:AnyObject]()
        
        for (key,value) in dictionary {
            if let obj = value as? NSObject {
                result[key] = obj.PS_toJsonObject(objectSet:objectSet)
            } else {
                result[key] = value.description
            }
        }
        return result
    }
    
}
