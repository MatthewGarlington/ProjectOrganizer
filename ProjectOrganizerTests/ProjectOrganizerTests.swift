//
//  ProjectOrganizerTests.swift
//  ProjectOrganizerTests
//
//  Created by Matthew Garlington on 3/18/21.
//

import CoreData
import XCTest
@testable import ProjectOrganizer

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
   
}

