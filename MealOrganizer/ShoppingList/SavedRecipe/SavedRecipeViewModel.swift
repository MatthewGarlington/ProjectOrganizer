//
//  SavedRecipeViewModel.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/4/21.
//

import Foundation
import CoreData
import SwiftUI

extension SavedRecipeView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        let dataController: DataController

        var sortOrder = Item.SortOrder.optimized
        let showSavedProjects: Bool

        private let projectController: NSFetchedResultsController<Project>
        @Published var projects = [Project]()

        init(dataController: DataController, showSavedProjects: Bool) {
            self.dataController = dataController
            self.showSavedProjects = showSavedProjects

            // Used to ensure MVVM where the request is
            // able to be accessed by other Views
            let request: NSFetchRequest<Project> = Project.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate,
                                                        ascending: false)
            ]
            request.predicate = NSPredicate(format: "saved = %d",
                                            showSavedProjects)

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

        func addProject() {
                let project = Project(context: dataController.container.viewContext)
                project.closed = false
                project.creationDate = Date()
                dataController.save()
        }

        func addItem(to project: Project) {
                let item = Item(context: dataController.container.viewContext)
                item.project = project
                item.creationDate = Date()
                dataController.save()
        }

        func delete(_ offsets: IndexSet, from project: Project) {
            let allItems = project.projectItems(using: sortOrder)
            for offset in offsets {
                let item = allItems[offset]
                dataController.delete(item)
            }
            dataController.save()
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }
    }
}

