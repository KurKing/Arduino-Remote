//
//  Arduino_RemoteUITests.swift
//  Arduino RemoteUITests
//
//  Created by Oleksii on 22.04.2024.
//

import XCTest

final class Arduino_RemoteUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        
        app.terminate()
        app = nil
    }
    
    func testExample() throws {
            
        let enterButton = app.buttons["enter-ip-address-button"]
        enterButton.tap()
        XCTAssertTrue(enterButton.exists)

        let ipAddressTextField = app.textFields["ip-address-text-field"]
        ipAddressTextField.tap()
        XCTAssertTrue(ipAddressTextField.exists)

        ipAddressTextField.typeText("1.555")
        
        enterButton.tap()
        XCTAssertTrue(enterButton.exists)
        XCTAssertTrue(ipAddressTextField.exists)
        
        ipAddressTextField.tap()
        ipAddressTextField.clearText()
        ipAddressTextField.clearText()
        
        enterButton.tap()
        XCTAssertTrue(enterButton.exists)
        XCTAssertTrue(ipAddressTextField.exists)
        
        ipAddressTextField.tap()
        ipAddressTextField.typeText("192.168.1.124")
        enterButton.tap()
        
        waitToHide(element: enterButton)
        waitToHide(element: ipAddressTextField)
    }
}

// MARK: - Helpers
extension XCUIElement {
    
    func clearText() {
        
        guard let stringValue = self.value as? String else {
            
            XCTFail("Attempting to clear and enter text into a non string value")
            return
        }
        
        tap()
        
        let deleteString = stringValue.map { _ in
            XCUIKeyboardKey.delete.rawValue
        }.joined(separator: "")
        
        typeText(deleteString)
    }
}

extension Arduino_RemoteUITests {
    
    func waitToAppear(element: XCUIElement) {
        
        let expectation =
        XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"),
                                  object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(result, .completed, "Failed to wait for the element to appear")
        
        XCTAssertTrue(element.exists)
    }
    
    func waitToHide(element: XCUIElement) {
        
        let expectation =
        XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"),
                                  object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(result, .completed, "Failed to wait for the element to disappear")
        
        XCTAssertFalse(element.exists)
    }
}
