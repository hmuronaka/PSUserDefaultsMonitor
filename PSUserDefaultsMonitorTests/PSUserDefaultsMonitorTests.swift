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
        
        XCTAssertTrue(dictionary.valueForDictionaryPath("a", separator: ".").description ==  "A", "")
        XCTAssertTrue(dictionary.valueForDictionaryPath("a.b", separator: ".").description ==  "B", "")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
