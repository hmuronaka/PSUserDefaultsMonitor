//
//  Weak.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/12.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

// http://stackoverflow.com/questions/24127587/how-do-i-declare-an-array-of-weak-references-in-swift

internal class Weak<T:AnyObject> : NSObject {
    
    weak var value: T!
    
    init(value:T!)  {
        super.init()
        self.value = value
    }

}