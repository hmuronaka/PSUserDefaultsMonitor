//
//  String+extension.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension String {
    
    internal func substringSafety(fromIndex  fromIndex:Int, length:Int) -> String {
        
        if fromIndex > self.characters.count {
            return ""
        }
        
        var endIndex:Int
        if(length == -1) {
            endIndex = self.characters.count
        } else {
            endIndex = fromIndex + length
            endIndex = min(endIndex, self.characters.count)
        }
        
        return self.substringWithRange(Range(start:self.startIndex.advancedBy(fromIndex), end:self.startIndex.advancedBy(endIndex)))
    }
    
    internal func substringSafety(fromIndex  fromIndex:Int) -> String {
        return substringSafety(fromIndex: fromIndex, length: -1)
    }
    
    internal func substringWithNSRange(nsrange:NSRange) -> String {
        return substringSafety(fromIndex:nsrange.location, length: nsrange.length)
    }
    
    internal func rangeFromNSRange(nsrange:NSRange) -> Range<String.Index> {
        return Range<String.Index>(start: self.startIndex.advancedBy(nsrange.location), end: self.startIndex.advancedBy(nsrange.location + nsrange.length))
    }
    
    internal func match(pattern:String) -> PAMatch  {
        var error:NSError?
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions())
        } catch let error1 as NSError {
            error = error1
            regex = nil
        }
        
        if error != nil {
            print("\(error!)")
        }
        
        let nsmatch = regex?.firstMatchInString(self , options: NSMatchingOptions(), range: NSMakeRange(0, self.characters.count))
        
        return PAMatch(originalString: self, match: nsmatch)
    }
    
    internal func removeMatchedString(pattern  pattern:String) -> String? {
        
        var error:NSError?
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions())
        } catch let error1 as NSError {
            error = error1
            regex = nil
        }
        
        if error != nil {
            print("\(error!)")
            return nil
        }
        
        let result = regex?.stringByReplacingMatchesInString(self, options: NSMatchingOptions(), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        return result
        
    }
    
}