//
//  SnackedTests.swift
//  SnackedTests
//
//  Created by Bernd on 25.11.21.
//

import XCTest

class SnackedTests: XCTestCase {

    var model:Model = Model(items: [])
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testInitialModel() throws {
        XCTAssertEqual(model.items.count, 0)
    }
    
    func testInsertModel() throws {
        let newItem = Item(title: "🍪", calories: 230.0, colorLiteral: "systemPink", createDate: Date())
        model.items.append(newItem)
        XCTAssertEqual(model.items.count, 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
