//
//  screenshotTest.swift
//  CountOnMeTests
//
//  Created by DELCROS Jean-baptiste on 20/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest

class screenshotTest: XCTestCase {

    
   
    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
    }
    
    func testScreenShot() {
        snapshot("portrait")
    }
    

}
