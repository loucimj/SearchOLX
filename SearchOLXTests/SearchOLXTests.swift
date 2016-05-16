//
//  SearchOLXTests.swift
//  SearchOLXTests
//
//  Created by Javi on 5/11/16.
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import XCTest
@testable import SearchOLX

class SearchOLXTests: XCTestCase,SearchLogic {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testService() {
        searchItems("autos")
    }
    
    func searchDidFinish(items: Array<SearchResultItem>) {
        
        if items.count == 0 {
            XCTFail("no items from query")
        } else {
            for item in items {
                print (item)
            }
            XCTAssert(true, "\(items.count)")
        }
    }
    
    
}
