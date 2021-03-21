//
//  AssetTest.swift
//  ProjectOrganizerTests
//
//  Created by Matthew Garlington on 3/18/21.
//
import XCTest
@testable import ProjectOrganizer

class AssetTest: XCTestCase {
    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load '\(color)' from asset catalog")
        }
    }
    func testJSONLoadsCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load awards from JSON")
    }
}
