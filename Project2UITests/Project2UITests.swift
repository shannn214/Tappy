//
//  Project2UITests.swift
//  Project2UITests
//
//  Created by 尚靖 on 2018/6/13.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import XCTest

class Project2UITests: XCTestCase {

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        let button = tabBarsQuery.children(matching: .button).element(boundBy: 0)
        button.tap()
        tabBarsQuery.children(matching: .button).element(boundBy: 1).tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).tap()

        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        button.tap()
        element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .scrollView).element(boundBy: 1).children(matching: .image).element.tap()

    }

}
