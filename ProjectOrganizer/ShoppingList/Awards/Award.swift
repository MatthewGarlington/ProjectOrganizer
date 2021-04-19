//
//  Award.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import Foundation


struct Award: Decodable, Identifiable {
    
    var id: String { name }
    let name: String
    let description: String
    let color: String
    let criterion: String
    let value: Int
    let image: String
    static let allAwards = Bundle.main.decode([Award].self, from: "Awards.json")
    static let example = allAwards[0]
    
}
