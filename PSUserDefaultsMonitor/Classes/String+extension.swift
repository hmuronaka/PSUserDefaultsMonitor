//
//  String+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension String {
    
    func substringSafety(fromIndex:Int, length:Int) -> String {
        
        if fromIndex > count(self) {
            return ""
        }
        
        var endIndex:Int
        if(length == -1) {
            endIndex = count(self)
        } else {
            endIndex = fromIndex + length
            endIndex = min(endIndex, count(self))
        }
        
        return self.substringWithRange(Range(start:advance(self.startIndex, fromIndex), end:advance(self.startIndex, endIndex)))
    }
    
    func substringSafety(# fromIndex:Int) -> String {
        return substringSafety(fromIndex, length: -1)
    }
}