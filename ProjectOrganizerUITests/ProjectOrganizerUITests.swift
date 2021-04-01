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
    
    func testOpenTabAddsProjects() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially.")
        
        for tapCount in 1...5 {
            app.buttons["add"].tap()
            XCTAssertEqual(app.tables.cells.count, tapCount, "There should be \(tapCount) list row(s) initially")
        }
    }
    
    func testAddingItemInsertsRows() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially.")
        
        app.buttons["add"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 list row after adding a project")
        
        app.buttons["Add new Item"].tap()
        XCTAssertEqual(app.tables.cells.count, 2, "There should be 2 list row after adding a Items")
    }
}
