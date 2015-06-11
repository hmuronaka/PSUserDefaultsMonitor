//
//  Dictionary+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by MuronakaHiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension NSDictionary {
    
    
    internal func PS_valueForDictionaryPath(path:String, separator:String) -> AnyObject! {
        
        var onePath = path
        
        if( onePath == "/" || onePath.isEmpty ) {
            return self
        }
        
        var range = path.rangeOfString(separator)
        if let location = range {
            onePath = path.substringToIndex(location.startIndex)
            if let children = self.objectForKey(onePath) as? NSDictionary {
                return children.PS_valueForDictionaryPath(path.substringFromIndex(location.startIndex.successor()), separator:separator)
            } else if let children = self.objectForKey(onePath) as? NSArray {
                return children.PS_valueForArrayPath(path.substringFromIndex(location.startIndex.successor()), separator:separator)
            } else if onePath.isEmpty {
                return self.PS_valueForDictionaryPath(path.substringFromIndex(location.startIndex.successor()), separator: separator)
            } else {
                return nil
            }
        } else {
            return self[onePath]
        }
        
    }
    
    internal override func PS_toJsonObject() -> AnyObject {
        
        return self.PS_toJsonObjectImpl(self as! [NSObject:AnyObject])
        
    }

    private func PS_toJsonObjectImpl(dictionary:[NSObject:AnyObject]) -> [NSObject:AnyObject] {
        
        var result = [NSObject:AnyObject]()
        
        for (key,value) in dictionary {
            result[key] = value.PS_toJsonObject()
        }
        return result
    }
    
}
