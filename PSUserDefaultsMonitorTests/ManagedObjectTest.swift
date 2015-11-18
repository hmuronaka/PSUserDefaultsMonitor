//
//  ManagedObjectTest.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/21.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import UIKit
import CoreData
import XCTest

class ManagedObjectTest: XCTestCase {
    
    var context:TestManagedObjectContext = TestManagedObjectContext()

    override func setUp() {
        super.setUp()
        
        Address.truncateAll(context.managedObjectContext)
        Person.truncateAll(context.managedObjectContext)
        do {
            try context.managedObjectContext?.save()
        } catch _ {
        }
        
        let obj:NSManagedObject? = Address.create(context.managedObjectContext)
        let address:Address! = obj as? Address
        
//        var address:Address = NSManagedObject.create(Address.self, managedObjectContext:context.managedObjectContext) as! Address
        address.address = "A"
        
        let address2 = Address.create(context.managedObjectContext) as! Address
        address2.address = "B"
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let p1 = Person.create(context.managedObjectContext) as! Person
        p1.name = "n1"
        p1.address = address
        
        let p2 = Person.create(context.managedObjectContext) as! Person
        p2.name = "n2"
        p2.address = address
        
        let p3 = Person.create(context.managedObjectContext) as! Person
        p3.name = "n3"
        p3.address = address2
        
        
    }
    
    override func tearDown() {
        
        Address.truncateAll(context.managedObjectContext)
        Person.truncateAll(context.managedObjectContext)
        do {
            try context.managedObjectContext?.save()
        } catch _ {
        }
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }

    func testAllAddress() {
        // This is an example of a functional test case.
        var addresses = Address.all(context.managedObjectContext) as! [Address]
        addresses.sortInPlace { (a, b) -> Bool in
            return a < b
        }
        XCTAssertEqual(2, addresses.count)
        XCTAssertEqual("A", addresses[0].address)
        XCTAssertEqual("B", addresses[1].address)
        
        
        let p3 = addresses[1].members.anyObject() as! Person
        XCTAssertEqual("n3", p3.name)
    }
    
    func testAllPerson() {
        let people = Person.all(context.managedObjectContext) as! [Person] as NSArray
        
        XCTAssertEqual(3, people.count)
        
        print("\(people.PS_toJsonObject())")
        
    }


}
