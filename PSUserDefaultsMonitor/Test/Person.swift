//
//  Person.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/21.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation
import CoreData

class Person: NSManagedObject {

    @NSManaged var age: NSNumber
    @NSManaged var birthday: NSDate
    @NSManaged var name: String
    @NSManaged var address: Address

}
