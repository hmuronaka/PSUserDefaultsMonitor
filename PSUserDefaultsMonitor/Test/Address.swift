//
//  Address.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/21.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation
import CoreData

class Address: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var members: NSSet
    
}
