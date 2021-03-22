//
//  DevelopmentTests.swift
//  ProjectOrganizerTests
//
//  Created by Matthew Garlington on 3/18/21.
//

import XCTest
import CoreData
@testable import ProjectOrganizer

class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()
        
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5, "There should be 5 sample projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50, "There should be 50 sample items.")
        
    }
    
    func testDeleteAllClearsEverything() throws {
      //  try dataController.createSampleData()
        dataController.deleteAll()
        
         XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0, "deleteAll() should leave 0 projects")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "deleteAll() should leave 0 items")
        
    }
    
    func testExampleProjectIsClosed() {
        let project = Project.example
        XCTAssertTrue(project.closed, "The example project should be closed.")
        
    }
    
    func testExampleItemIsHighPriority() {
        let item = Item.example
        XCTAssertEqual(item.priority, 3, "The example item should be high priority.")
        
    }
}
