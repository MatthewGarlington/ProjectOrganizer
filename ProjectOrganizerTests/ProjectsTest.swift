//
//  ProjectsTest.swift
//  ProjectOrganizerTests
//
//  Created by Matthew Garlington on 3/18/21.
//

import XCTest
import CoreData
@testable import ProjectOrganizer

class ProjectsTest: BaseTestCase {

    func testCreatingProjectsandItems() {
        let targetCount = 10
        
        for _ in 0..<targetCount {
            let project = Project(context: managedObjectContext)
            
            for _ in 0..<targetCount {
                let item = Item(context: managedObjectContext)
                item.project = project
                
            }
        }
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), targetCount)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), targetCount * targetCount)
    }
    
    func testDeletingProjectCascadeDeletesItems() throws {
        try dataController.createSampleData()
        
        let request = NSFetchRequest<Project>(entityName: "Project")
        let projects = try managedObjectContext.fetch(request)
        
        dataController.delete(projects[0])
        
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 4)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 40)
    }

}
