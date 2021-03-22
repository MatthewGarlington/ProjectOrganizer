//
//  AwardTests.swift
//  ProjectOrganizerTests
//
//  Created by Matthew Garlington on 3/18/21.
//
import XCTest
import CoreData
@testable import ProjectOrganizer

class AwardTests: BaseTestCase {
    let awards = Award.allAwards
    
    func testAwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should always match its name")
            
        }
        
    }
    
    func testNewUserHasNoAwards() {
        
        for award in awards {
            
            XCTAssertFalse(dataController.hasEarned(award: award), "New users should have no earned awards")
            
        }
        
    }
    
    func testAddingItems() {
        
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        
        for (count, value) in values.enumerated() {
            for _ in 0..<value {
                _  = Item(context: managedObjectContext)
            
            }
            
            let matches = awards.filter { award in
                award.criterion == "items" && dataController.hasEarned(award: award)
            }
            
            XCTAssertEqual(matches.count, count + 1, "Adding \(value) items should unlock \(count + 1)")
            
    
                dataController.deleteAll()
       
        }
        
    }
    
    func testCompletingItems() {
        
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        
        for (count, value) in values.enumerated() {

            for _ in 0..<value {
               let item = Item(context: managedObjectContext)
                item.completed = true
            
         
            }
            
            let matches = awards.filter { award in
                award.criterion == "complete" && dataController.hasEarned(award: award)
            }
            
            XCTAssertEqual(matches.count, count + 1, "completing \(value) items should unlock \(count + 1)")
            

                dataController.deleteAll()
       
            
        }
        
    }

}
