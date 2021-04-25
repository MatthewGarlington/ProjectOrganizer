//
//  HomeViewViewModel.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/2/21.
//

import Foundation
import CoreData

extension HomeView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        private let projectsController: NSFetchedResultsController<Project>
        private let itemsController:  NSFetchedResultsController<Item>
     
        
        @Published var projects = [Project]()
        @Published var items = [Item]()
        
        var dataController: DataController
        
      
        
        var moreToExplore: ArraySlice<Item> {
            items.dropLast(0)
        }
        
        init(dataController: DataController) {
            self.dataController = dataController
            
            // Construct a Fetch Request to Show all Open Projects
            let projectRequest: NSFetchRequest<Project> = Project.fetchRequest()
            projectRequest.predicate = NSPredicate(format: "closed = false")
            projectRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Project.title, ascending: true)]
            
            projectsController = NSFetchedResultsController(fetchRequest: projectRequest,
                                                            managedObjectContext: dataController.container.viewContext,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: nil
            )
            // Construct a Fetch Request to Show the 10 Priority Items,
            // incomplete Items from open projects
            
            let itemRequest: NSFetchRequest<Item> = Item.fetchRequest()
            
            let completedPredicate = NSPredicate(format: "completed = false")
            let openPredicate = NSPredicate(format: "project.closed = false")
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [completedPredicate, openPredicate])
            itemRequest.predicate = compoundPredicate
          
            itemRequest.sortDescriptors = [
                NSSortDescriptor(keyPath: \Item.priority, ascending: false)
            ]
            
            itemRequest.fetchLimit = 10
            
            itemsController = NSFetchedResultsController(fetchRequest: itemRequest,
                                                         managedObjectContext: dataController.container.viewContext,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: nil
            )

            super.init()
            
            projectsController.delegate = self
            itemsController.delegate = self
            
            do {
                try projectsController.performFetch()
                try itemsController.performFetch()
                projects = projectsController.fetchedObjects ?? []
                items = itemsController.fetchedObjects ?? []
            } catch {
                print("Failed to Fetch initial data")
            }
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newItems = controller.fetchedObjects as? [Item] {
                items = newItems
            } else if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }
        
        func addSampleData() {
            dataController.deleteAll()
            try? dataController.createSampleData()
        }
    }
}

