//
//  toJSONObjectTest.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/19.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation
import XCTest

class toJSONObjectTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testObjectToJson() {
        
        let obj = NSObject()
        // This is an example of a functional test case.
        //println(obj.PS_toJsonObject())
        obj.PS_toJsonObject()
        XCTAssertTrue(true)
    }

    func testStringToJson() {
        
        let obj = "ABCDE"
        // This is an example of a functional test case.
        //println(obj.PS_toJsonObject())
        obj.PS_toJsonObject()
        XCTAssertEqual("ABCDE", obj.PS_toJsonObject() as! String)
    }
    
    func testNumberToJson() {
        
        let obj = NSNumber(int:20)
        
        XCTAssertEqual(NSNumber(int:20), obj.PS_toJsonObject() as! NSNumber)
    }
    
    func testAddress() {
        
        let address = Address("kanagawa")
        
        let json = address.PS_toJsonObject() as! NSDictionary
        XCTAssertEqual(1, json.count)
        XCTAssertEqual("kanagawa", json["address"] as! String)
    }
    
    func testPersonAndAddressIsNil() {
        
        let person = Person(name: "ABC", age: 1)
        let json = person.PS_toJsonObject() as! NSDictionary
        XCTAssertEqual(3, json.count)
        XCTAssertEqual("ABC", json["name"] as! String)
        XCTAssertEqual(NSNumber(int: 1), json["age"] as! NSNumber)
        XCTAssertEqual("<null>", json["address"] as! String)
    }
    
    func testPerson() {
        
        let person = Person(name: "ABC", age: 1)
        person.address = Address("ADDRESS")
        
        let json = person.PS_toJsonObject() as! NSDictionary
        XCTAssertEqual(3, json.count)
        XCTAssertEqual("ABC", json["name"] as! String)
        XCTAssertEqual(NSNumber(int: 1), json["age"] as! NSNumber)
        println(json)
        
        if let address = json["address"] as? NSDictionary {
            XCTAssertEqual("ADDRESS", address["address"] as! String)
        }
    }
    
    func testFamily() {
        
        let family = Family()
        family.member.append(Person(name: "A", age: 1))
        family.member.append(Person(name: "B", age: 2))
        
        let json = family.PS_toJsonObject() as! NSDictionary
        
        let members = json["member"] as! NSArray
        
        println(json)
        XCTAssertEqual(2, members.count)
        
        let m1 = members[0] as! NSDictionary
        XCTAssertEqual("A", m1["name"] as! String)
        
        let m2 = members[1] as! NSDictionary
        XCTAssertEqual("B", m2["name"] as! String)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
