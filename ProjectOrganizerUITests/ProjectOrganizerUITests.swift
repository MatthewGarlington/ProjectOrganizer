//
//  ProjectOrganizerUITests.swift
//  ProjectOrganizerUITests
//
//  Created by Matthew Garlington on 3/18/21.
//

import XCTest

class ProjectOrganizerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }



    func testAppHas4Tabs() throws {
        XCTAssertEqual(app.tabBars.buttons.count, 4, "There should be 4 Tabs in the App")

    }
}
