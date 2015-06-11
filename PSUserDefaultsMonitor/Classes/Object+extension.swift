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
        
        if NSJSONSerialization.isValidJSONObject(self) {
            return self
        } else {
            return self.description
        }
    }
}