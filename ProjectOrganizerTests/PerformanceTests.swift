//
//  PerformanceTests.swift
//  ProjectOrganizerTests
//
//  Created by Matthew Garlington on 3/18/21.
//

import XCTest
@testable import ProjectOrganizer

class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() throws {
        // Create a significant amount of test data
        for _ in 1...100 {
        try dataController.createSampleData()
        }
        // Simulate a lot of awards to check
        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        
        // Only execute this test if the awards are at this amount 
        XCTAssertEqual(awards.count, 500, "This checks the number of awards is constant. Change this if you add new awards.")
        
        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
