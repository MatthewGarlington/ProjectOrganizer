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
        app.buttons["To Get"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially.")
        
        for tapCount in 1...5 {
            app.buttons["add"].tap()
            XCTAssertEqual(app.tables.cells.count, tapCount, "There should be \(tapCount) list row(s) initially")
        }
    }
    
    func testAddingItemInsertsRows() {
        app.buttons["To Get"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially.")
        
        app.buttons["add"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 list row after adding a project")
        
        app.buttons["Add New Ingredient"].tap()
        XCTAssertEqual(app.tables.cells.count, 2, "There should be 2 list row after adding a Items")
    }
    
//    func testingEditingProjectUpdatesCorrectly() {
//        app.buttons["Open"].tap()
//        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially.")
//
//        app.buttons["add"].tap()
//        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 list row after adding a project")
//
//        app.buttons["NEW PROJECT"].tap()
//        app.textFields["Project name"].tap()
//
//        app.keys["space"].tap()
//        app.keys["more"].tap()
//        app.keys["2"].tap()
//        app.buttons["Return"].tap()
//
//        app.buttons["Open Projects"].tap()
//        XCTAssertTrue(app.buttons["NEW PROJECT 2"].exists, "The new project name should be visible in the list")
//
//    }
    
    
//    func testingEditingItemUpdatesCorrectly() {
//        app.buttons["Open"].tap()
//        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially.")
//
//        app.buttons["add"].tap()
//        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 list row after adding a project")
//
//        app.buttons["Add new Item"].tap()
//        XCTAssertEqual(app.tables.cells.count, 2, "There should be 2 list row after adding an item.")
//
//        app.buttons["New Item"].tap()
//        app.textFields["Item name"].tap()
//
//        app.keys["space"].tap()
//        app.keys["more"].tap()
//        app.keys["2"].tap()
//        app.buttons["Return"].tap()
//
//        app.buttons["Open Projects"].tap()
//        XCTAssertTrue(app.buttons["New Item 2"].exists, "The new Item name should be visible in the list")
//
//    }
//
    
    func testAllAwardsShowLockedAlert() {
        app.buttons["Awards"].tap()
        
        for award in app.scrollViews.buttons.allElementsBoundByIndex {
            award.tap()
            
            XCTAssertTrue(app.alerts["Locked"].exists, "There should be a locked alert showing for awards.")
            app.buttons["Ok"].tap()
        }
    }
}
