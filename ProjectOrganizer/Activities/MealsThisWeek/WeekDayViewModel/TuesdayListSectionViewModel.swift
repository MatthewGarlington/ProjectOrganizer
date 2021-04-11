//
//  TuesdayListSectionViewModel.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/10/21.
//

import Foundation
import CoreData
import SwiftUI


extension TuesdayListSection {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        let dataController: DataController

        var sortOrder = Item.SortOrder.optimized
        let tuesdayAssignment: Bool

        private let projectController: NSFetchedResultsController<Project>
        @Published var projects = [Project]()

        init(dataController: DataController, tuesdayAssignment: Bool) {
            self.dataController = dataController
            self.tuesdayAssignment = tuesdayAssignment

            // Used to ensure MVVM where the request is
            // able to be accessed by other Views
            let request: NSFetchRequest<Project> = Project.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)]
            request.predicate = NSPredicate(format: "tuesdayAssignment = %d", tuesdayAssignment)

            projectController = NSFetchedResultsController(fetchRequest: request,
                                                           managedObjectContext: dataController.container.viewContext,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil
            )

            super.init()
            projectController.delegate = self

            do {
                try projectController.performFetch()
                projects = projectController.fetchedObjects ?? []

            } catch {
                print("Failed to fetch our Recipes")
            }

        }


        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }

    }
}

