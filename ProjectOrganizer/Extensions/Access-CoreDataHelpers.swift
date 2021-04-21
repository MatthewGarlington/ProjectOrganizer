//
//  Access-CoreDataHelpers.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/19/21.
//

import Foundation



// This extension hides the optional values in the other views needed to satisfy Core Data
extension Access {

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




    var homeAccentColor: String {
        accentColor ?? "Green"
    }
    var homeBackgroundColor: String {
        backgroundColor ?? "Green"
    }


    static var example: Access {
        let controller = DataController.preview
        let viewContext = controller.container.viewContext
        let access = Access(context: viewContext)
        access.accentColor = "Green"
        access.backgroundColor = "Green"


        return access
    }

}

