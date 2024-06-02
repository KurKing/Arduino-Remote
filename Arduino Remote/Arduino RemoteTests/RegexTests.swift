//
//  RegexTests.swift
//  Arduino RemoteTests
//
//  Created by Oleksii on 02.06.2024.
//

import XCTest
@testable import Arduino_Remote

final class RegexTests: XCTestCase {

    override func setUpWithError() throws { /* ... */ }

    override func tearDownWithError() throws { /* ... */ }
    
    func testTrimmed() {
        
        XCTAssertEqual("   hello   ".trimmed, "hello")
        XCTAssertEqual("\n\t hello \n\t".trimmed, "hello")
        XCTAssertEqual("hello".trimmed, "hello")
        XCTAssertEqual("   ".trimmed, "")
        XCTAssertEqual("\n\t".trimmed, "")
    }

    func testEmptyToNil() {
        
        XCTAssertNil("   ".emptyToNil)
        XCTAssertNil("\n\t".emptyToNil)
        XCTAssertNil("".emptyToNil)
        
        XCTAssertEqual("hello".emptyToNil, "hello")
        XCTAssertEqual("   hello   ".emptyToNil, "hello")
        XCTAssertEqual("\n\t hello \n\t".emptyToNil, "hello")
    }

    func testIpAddress() {
        
        XCTAssertTrue("192.168.0.1".isIpAddress)
        XCTAssertTrue("255.255.255.255".isIpAddress)
        XCTAssertTrue("0.0.0.0".isIpAddress)
        
        XCTAssertFalse("256.256.256.256".isIpAddress)
        XCTAssertFalse("192.168.0".isIpAddress)
        XCTAssertFalse("192.168.0.1.1".isIpAddress)
        XCTAssertFalse("192.168.0.abc".isIpAddress)
        XCTAssertFalse("192.168.0.1.".isIpAddress)
        XCTAssertFalse(".192.168.0.1".isIpAddress)
        XCTAssertFalse("".isIpAddress)
        XCTAssertFalse("  ".isIpAddress)
    }
    
    func testContainsOnlyNumbersAndDots() {
        
        XCTAssertTrue("123.456".containsOnlyNumbersAndDots)
        XCTAssertTrue("0.123456789".containsOnlyNumbersAndDots)
        XCTAssertTrue("123.45.67.89".containsOnlyNumbersAndDots)
        XCTAssertTrue("123..456".containsOnlyNumbersAndDots)
        XCTAssertTrue("123456".containsOnlyNumbersAndDots)
        XCTAssertTrue("...".containsOnlyNumbersAndDots)
        
        XCTAssertFalse("123a.456".containsOnlyNumbersAndDots)
        XCTAssertFalse("".containsOnlyNumbersAndDots)
        XCTAssertFalse(" ".containsOnlyNumbersAndDots)
    }
}
