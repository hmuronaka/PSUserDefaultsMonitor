//
//  String+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension String {
    
    internal func substringSafety(# fromIndex:Int, length:Int) -> String {
        
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
    
    internal func substringSafety(# fromIndex:Int) -> String {
        return substringSafety(fromIndex: fromIndex, length: -1)
    }
    
    internal func substringWithNSRange(nsrange:NSRange) -> String {
        return substringSafety(fromIndex:nsrange.location, length: nsrange.length)
    }
    
    internal func rangeFromNSRange(nsrange:NSRange) -> Range<String.Index> {
        return Range<String.Index>(start: advance(self.startIndex, nsrange.location), end: advance(self.startIndex, nsrange.location + nsrange.length))
    }
    
    internal func match(pattern:String) -> PAMatch  {
        var error:NSError?
        let regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.allZeros, error: &error)
        
        if error != nil {
            println("\(error!)")
        }
        
        let nsmatch = regex?.firstMatchInString(self , options: NSMatchingOptions.allZeros, range: NSMakeRange(0, count(self)))
        
        return PAMatch(originalString: self, match: nsmatch)
    }
    
    internal func removeMatchedString(# pattern:String) -> String? {
        
        var error:NSError?
        let regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.allZeros, error: &error)
        
        if error != nil {
            println("\(error!)")
            return nil
        }
        
        let result = regex?.stringByReplacingMatchesInString(self, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, count(self)), withTemplate: "")
        
        return result
        
    }
    
}