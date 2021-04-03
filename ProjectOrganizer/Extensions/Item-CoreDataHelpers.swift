//
//  Item-CoreDataHelpers.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import Foundation

// This extension hides the optional values in the other views needed to satisfy Core Data
extension Item {
    enum SortOrder {
        case optimized, title, creationDate
    }
    var itemTitle: String {
        title ?? NSLocalizedString("New Ingredient", comment: "Add a new New ingredient")
    }
    var itemDetail: String {
        detail ?? ""
    }
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    static var example: Item {
        let controller = DataController.preview
        let viewContext = controller.container.viewContext
        let item = Item(context: viewContext)
        item.title = "Example Ingredient"
        item.detail = "This is an example ingredient"
        item.priority = 3
        item.creationDate = Date()
        
        return item
    }
}
