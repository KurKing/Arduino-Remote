//
//  ButtonNodeModeTests.swift
//  Arduino RemoteTests
//
//  Created by Oleksii on 02.06.2024.
//

import XCTest
@testable import Arduino_Remote

final class ButtonNodeModeTests: XCTestCase {
    
    override func setUpWithError() throws { /* ... */ }
    
    override func tearDownWithError() throws { /* ... */ }
    
    func testModeForIndex() {
        
        XCTAssertEqual(ButtonNodeMode.mode(for: 0), .oneClick)
        XCTAssertEqual(ButtonNodeMode.mode(for: 1), .buttonSwitch)
        
        XCTAssertEqual(ButtonNodeMode.mode(for: 2), .oneClick)
        XCTAssertEqual(ButtonNodeMode.mode(for: -1), .oneClick)
    }
    
    func testIntIndex() {
        
        XCTAssertEqual(ButtonNodeMode.oneClick.intIndex, 0)
        XCTAssertEqual(ButtonNodeMode.buttonSwitch.intIndex, 1)
    }
}
