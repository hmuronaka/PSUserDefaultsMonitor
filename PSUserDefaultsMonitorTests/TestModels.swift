//
//  File.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

class Address : NSObject {
    var address:String
    
    init(_ address:String) {
        self.address = address
        super.init()
    }
}

class Person : NSObject {
    var name:String?
    var age:Int
    var address:Address?
    
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
}

class Family : NSObject {
    
    var member:Array<Person> = []
    
}