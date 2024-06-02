//
//  Arduino_RemoteUITests.swift
//  Arduino RemoteUITests
//
//  Created by Oleksii on 22.04.2024.
//

import XCTest

final class Arduino_RemoteUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var testSchemeName: String { "MySchemeName" }
    
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
    
    func testUserFlow() throws {
            
        ipAddressEnter()
        createAndEnterScheme()
        schemeButtons()
        deleteRow()
    }
}

// MARK: - Ip address enter
extension Arduino_RemoteUITests {
 
    func ipAddressEnter() {
        
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

// MARK: - Schemes list
extension Arduino_RemoteUITests {
 
    func createAndEnterScheme() {
        
        let addButton = app.navigationBars["Arduino_Remote.SchemesListView"].buttons["Add"]
        XCTAssertTrue(addButton.exists)
        
        addButton.tap()
        enterName("\(testSchemeName)_1")
        
        addButton.tap()
        let testText = enterName(testSchemeName)
        testText.tap()
    }
    
    @discardableResult
    private func enterName(_ name: String) -> XCUIElement {
        
        let enterButton = app.buttons["enter-name-ok-button"]
        XCTAssertTrue(enterButton.exists)
        
        let textField = app.textFields["enter-name-text-field"]
        textField.tap()
        XCTAssertTrue(textField.exists)
        textField.typeText(name)
        
        enterButton.tap()
        
        waitToHide(element: textField)
        waitToHide(element: enterButton)
        
        let testText = app.staticTexts[name]
        XCTAssertTrue(testText.exists)
        
        return testText
    }
    
    func deleteRow() {
        
        waitOneSecond()
        
        let cell = app.tables["schemes-list-table"].cells["scheme-list-item-0"]
        XCTAssertTrue(cell.exists)
        
        let testText = app.staticTexts[testSchemeName]
        XCTAssertTrue(testText.exists)
        
        cell.swipeLeft()
        
        let deleteButton = cell.buttons["Delete"]
        XCTAssertTrue(deleteButton.exists)
        deleteButton.tap()
    }
}

// MARK: - Scheme
extension Arduino_RemoteUITests {
    
    func schemeButtons() {
        
        let testNavigationBar = app.navigationBars[testSchemeName]
        XCTAssertTrue(testNavigationBar.exists)
        
        let playButton = testNavigationBar.buttons["play"]
        XCTAssertTrue(playButton.exists)
        playButton.tap()
        testNavigationBar.buttons["play-scheme-button"].tap()
        
        testNavigationBar.buttons["Back"].tap()
        
        waitToHide(element: testNavigationBar)
    }
}

// MARK: - Helpers
extension XCUIElement {
    
    func clearText() {
        
        guard let stringValue = self.value as? String else {
            XCTFail("Clear text fail")
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
    
    func waitToHide(element: XCUIElement) {
        
        let expectation =
        XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"),
                                  object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(result, .completed)
        
        XCTAssertFalse(element.exists)
    }
    
    func waitOneSecond() {
        
        let expectation = XCTestExpectation(description: "Wait for 1 second")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)
    }
}
