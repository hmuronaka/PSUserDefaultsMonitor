//
//  StringExtensionTest.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import UIKit
import XCTest

class StringExtensionTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSubString() {
        
        XCTAssertEqual("A", "A".substringSafety(fromIndex: 0, length: 1))
        
        
        XCTAssertEqual("B", "ABC".substringSafety(fromIndex: 1, length: 1))
        XCTAssertEqual("BC", "ABC".substringSafety(fromIndex: 1, length: 2))
        XCTAssertEqual("BC", "ABC".substringSafety(fromIndex: 1, length: 6))
        
        XCTAssertEqual("", "ABC".substringSafety(fromIndex: 3, length: 6))
        XCTAssertEqual("", "ABC".substringSafety(fromIndex: 4, length: 1))
        
        XCTAssertEqual("", "ABC".substringSafety(fromIndex: 0, length: 0))
        XCTAssertEqual("", "".substringSafety(fromIndex: 0, length: 1))
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
