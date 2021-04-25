//
//  WednesdayListSectionViewModel.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/10/21.
//
import Foundation
import CoreData
import SwiftUI


extension WednesdayListSection {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        let dataController: DataController

        var sortOrder = Item.SortOrder.optimized
        let wednesdayAssignment: Bool

        private let projectController: NSFetchedResultsController<Project>
        @Published var projects = [Project]()

        init(dataController: DataController, wednesdayAssignment: Bool) {
            self.dataController = dataController
            self.wednesdayAssignment = wednesdayAssignment

            // Used to ensure MVVM where the request is
            // able to be accessed by other Views
            let request: NSFetchRequest<Project> = Project.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.position, ascending: true)]
            request.predicate = NSPredicate(format: "wednesdayAssignment = %d", wednesdayAssignment)

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

