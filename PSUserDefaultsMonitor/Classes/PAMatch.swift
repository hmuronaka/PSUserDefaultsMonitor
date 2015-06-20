//
//  PAMatch.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import UIKit

internal class PAMatch: NSObject {
    
    let originalString:String
    var match:NSTextCheckingResult!
    
    var count:Int {
        get {
            if let result = match {
                return result.numberOfRanges
            } else {
                return 0
            }
        }
    }
    
    init(originalString:String, match: NSTextCheckingResult!) {
        self.originalString = originalString
        self.match = match
    }
    
    internal subscript(index:Int) -> String? {
        
        if let result = match {
            let range = result.rangeAtIndex(index)
            return self.originalString.substringWithNSRange(range)
        } else {
            return nil
        }
    }
    
    
   
}
