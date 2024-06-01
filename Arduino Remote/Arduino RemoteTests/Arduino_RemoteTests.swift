//
//  Arduino_RemoteTests.swift
//  Arduino RemoteTests
//
//  Created by Oleksii on 22.04.2024.
//

import XCTest
@testable import Arduino_Remote

final class Arduino_RemoteTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        XCTAssert("192.168.1.125".isIpAddress, "la la la")
    }
}
