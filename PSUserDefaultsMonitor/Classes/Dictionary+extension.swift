//
//  Dictionary+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by MuronakaHiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension NSDictionary {
    
    internal func PS_jsonDictionaryFromDictionary() -> [NSObject:AnyObject] {
        
        return self.PS_jsonDictionaryFromDictionaryImpl(self as! [NSObject:AnyObject])
        
    }
    
    internal func valueForDictionaryPath(path:String, separator:String) -> AnyObject! {
        
        var onePath = path
        
        var range = path.rangeOfString(separator)
        if let location = range {
            onePath = path.substringToIndex(location.startIndex)
            if let children = self.objectForKey(onePath) as? NSDictionary {
                return valueForDictionaryPath(path.substringFromIndex(location.startIndex), separator:separator)
                
            } else {
                return nil
            }
        } else {
            return self[onePath]
        }
        
    }
    
    private func PS_jsonDictionaryFromDictionaryImpl(dictionary:[NSObject:AnyObject]) -> [NSObject:AnyObject] {
        
        var result = [NSObject:AnyObject]()
        
        for (key,value) in dictionary {
            
            if value is NSDictionary {
                result[key] = PS_jsonDictionaryFromDictionaryImpl(value as! [NSObject:AnyObject])
            } else {
                if NSJSONSerialization.isValidJSONObject(value) {
                    result[key] = value
                } else {
                    result[key] = value.description
                }
            }
            
        }
        return result
    }
    
}
