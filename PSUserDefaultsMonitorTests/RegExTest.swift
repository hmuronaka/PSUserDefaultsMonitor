//
//  RegExTest.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import UIKit
import XCTest

class RegExTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let paMatch:PAMatch = "http://C/TableName/".match("http://C/(.*)/")
        XCTAssertEqual(paMatch[0]!, "http://C/TableName/")
        XCTAssertEqual(paMatch[1]!, "TableName")
        
        let paMatch2:PAMatch = "http://C/TableName/".match("http://C/([^/]+)")
        XCTAssertEqual(paMatch2[0]!, "http://C/TableName")
        XCTAssertEqual(paMatch2[1]!, "TableName")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRemovePattern() {
        
        XCTAssertEqual("ABC", "ABC".removeMatchedString(pattern: "^.*\\."))
        XCTAssertEqual("DEF", "ABC.DEF".removeMatchedString(pattern: "^.*\\."))
        XCTAssertEqual("GHI", "ABC.DEF.GHI".removeMatchedString(pattern: "^(.*\\.)*"))
        
    }

}
