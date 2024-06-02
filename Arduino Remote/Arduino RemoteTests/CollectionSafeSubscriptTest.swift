//
//  CollectionSafeSubscriptTest.swift
//  Arduino RemoteTests
//
//  Created by Oleksii on 02.06.2024.
//

import XCTest
@testable import Arduino_Remote

final class CollectionSafeSubscriptTest: XCTestCase {
    
    override func setUpWithError() throws { /* ... */ }
    
    override func tearDownWithError() throws { /* ... */ }
    
    func testSafeSubscriptWithArray() {
        
        let array = [1, 2, 3, 4, 5]
        
        XCTAssertEqual(array[safe: 0], 1)
        XCTAssertEqual(array[safe: 4], 5)
        XCTAssertNil(array[safe: 5])
        XCTAssertNil(array[safe: -1])
    }
    
    func testSafeSubscriptWithString() {
        
        let string = "hello"
        
        XCTAssertEqual(string[safe: string.startIndex], "h")
        XCTAssertEqual(string[safe: string.index(before: string.endIndex)], "o")
        XCTAssertNil(string[safe: string.endIndex])
    }
    
    func testSafeSubscriptWithEmptyArray() {
        
        let emptyArray: [Int] = []
        
        XCTAssertNil(emptyArray[safe: 0])
    }
    
    func testSafeSubscriptWithEmptyString() {
        
        let emptyString = ""
        
        XCTAssertNil(emptyString[safe: emptyString.startIndex])
    }
}
