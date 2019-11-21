//
//  CountOnMeUITestsScreen.swift
//  CountOnMeUITestsScreen
//
//  Created by DELCROS Jean-baptiste on 12/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest

class CountOnMeUITestsScreen: XCTestCase {

    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func testScreenShot() {
        snapshot("portrait")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
