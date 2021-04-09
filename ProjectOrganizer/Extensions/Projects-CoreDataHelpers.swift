//
//  Projects-CoreDataHelpers.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import Foundation



// This extension hides the optional values in the other views needed to satisfy Core Data
extension Project {
    
    // Adding the colors to be used through the project that are static so they can be referenced
    
    static let colors = ["Pink",
                         "Purple",
                         "Orange",
                         "Gold",
                         "Green",
                         "Teal",
                         "Light Blue",
                         "Dark Blue",
                         "Midnight",
                         "Dark Gray",
                         "Gray"]

   static let weekDays = ["No Day Selected",
                          "Sunday",
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                          "Friday",
                          "Saturday"]
    
    var projectTitle: String {
        title ?? NSLocalizedString("New Recipe", comment: "Create a new recipe")
    }
    var projectDetail: String {
        detail ?? ""
    }
    var projectColor: String {
        color ?? "Green"
    }
    var projectDay: String {
        day ?? "Monday"
    }
    var projectItems: [Item]  {
        items?.allObjects as? [Item] ?? []
    }
    var projectItemsDefaultSorted: [Item] {
        projectItems.sorted { first, second in
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }
            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }
        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }
    static var example: Project {
        let controller = DataController.preview
        let viewContext = controller.container.viewContext
        let project = Project(context: viewContext)
        project.title = "Example Recipe"
        project.detail = "This is an example recipe"
        project.closed = true
        project.saved = true
        project.creationDate = Date()
        
        return project
    }
    func projectItems(using sortOrder: Item.SortOrder) -> [Item] {
        switch sortOrder {
        case .title:
            return projectItems.sorted(by: \Item.itemTitle)
            
        case .creationDate:
            return projectItems.sorted(by: \Item.itemCreationDate)
            
        case .optimized:
            return projectItemsDefaultSorted
        }
    }
}

