//
//  PSUserDefaultsMonitorTests.swift
//  PSUserDefaultsMonitorTests
//
//  Created by MuronakaHiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import UIKit
import XCTest

class PSUserDefaultsMonitorTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testDictionaryKeyPath() {
        var dictionary = NSMutableDictionary()
        dictionary["a"] = "A"
        var dictionary2 = NSMutableDictionary()
        dictionary2["b"] = "B"
        dictionary["b"] = dictionary2
        dictionary2["numbers"] = [1,2,3]
        dictionary["c"] = dictionary2
        dictionary2["anys"] = [1, "abc", ["Z": "zzz"]]
        
        XCTAssertTrue(dictionary.PS_valueForDictionaryPath("a", separator: ".").description ==  "A", "")
        XCTAssertTrue(dictionary.PS_valueForDictionaryPath("b.b", separator: ".").description ==  "B", "")
        XCTAssertTrue(dictionary.PS_valueForDictionaryPath("c", separator: ".").isEqual(dictionary2), "")
        XCTAssertEqual(dictionary.PS_valueForDictionaryPath("", separator: ".") as! NSDictionary, dictionary)
        XCTAssertEqual(dictionary.PS_valueForDictionaryPath(".", separator: ".") as! NSDictionary, dictionary)
        XCTAssertNil(dictionary.PS_valueForDictionaryPath("a.", separator: "."))
        XCTAssertEqual(dictionary.PS_valueForDictionaryPath("c.numbers.0", separator: ".") as! NSNumber, NSNumber(int:1), "")
        XCTAssertEqual(dictionary.PS_valueForDictionaryPath("c.anys.1", separator: ".") as! String, "abc", "")
        XCTAssertEqual(dictionary.PS_valueForDictionaryPath("c.anys.1", separator: ".") as! String, "abc", "")
        XCTAssertEqual(dictionary.PS_valueForDictionaryPath("c.anys.2.Z", separator: ".") as! String, "zzz", "")

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
