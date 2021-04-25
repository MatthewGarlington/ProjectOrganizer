//
//  HomeSettingsViewModel.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/19/21.
//
//
//import Foundation
//import CoreData
//import SwiftUI
//
//extension smallLightCircle {
//    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
//        let dataController: DataController
//
//
//        let backgroundColor: String
//
//        private let projectController: NSFetchedResultsController<Access>
//        @Published var access = [Access]()
//
//        init(dataController: DataController, backgroundColor: String) {
//            self.dataController = dataController
//            self.backgroundColor = backgroundColor
//
//
//            // Used to ensure MVVM where the request is
//            // able to be accessed by other Views
//            let request: NSFetchRequest<Access> = Access.fetchRequest()
//
//            request.predicate = NSPredicate(format: "backgroundColor = %d", backgroundColor)
//            request.sortDescriptors = [
//                NSSortDescriptor(keyPath: \Access.backgroundColor, ascending: true),
//            ]
//
//
//            projectController = NSFetchedResultsController(fetchRequest: request,
//                                                           managedObjectContext: dataController.container.viewContext,
//                                                           sectionNameKeyPath: nil,
//                                                           cacheName: nil
//            )
//
//            super.init()
//            projectController.delegate = self
//
//            do {
//                try projectController.performFetch()
//                access = projectController.fetchedObjects ?? []
//
//            } catch {
//                print("Failed to fetch our Recipes")
//            }
//
//        }
//
//        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//            if let newAccess = controller.fetchedObjects as? [Access] {
//                access = newAccess
//            }
//        }
//    }
//}
//
//extension leftCornerCircle {
//    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
//        let dataController: DataController
//
//
//        let backgroundColor: String
//
//        private let projectController: NSFetchedResultsController<Access>
//        @Published var access = [Access]()
//
//        init(dataController: DataController, backgroundColor: String) {
//            self.dataController = dataController
//            self.backgroundColor = backgroundColor
//
//
//            // Used to ensure MVVM where the request is
//            // able to be accessed by other Views
//            let request: NSFetchRequest<Access> = Access.fetchRequest()
//
//            request.predicate = NSPredicate(format: "backgroundColor = %d", backgroundColor)
//            request.sortDescriptors = [
//                NSSortDescriptor(keyPath: \Access.backgroundColor, ascending: true),
//
//
//            ]
//
//
//            projectController = NSFetchedResultsController(fetchRequest: request,
//                                                           managedObjectContext: dataController.container.viewContext,
//                                                           sectionNameKeyPath: nil,
//                                                           cacheName: nil
//            )
//
//            super.init()
//            projectController.delegate = self
//
//            do {
//                try projectController.performFetch()
//                access = projectController.fetchedObjects ?? []
//
//            } catch {
//                print("Failed to fetch our Recipes")
//            }
//
//        }
//
//        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//            if let newAccess = controller.fetchedObjects as? [Access] {
//                access = newAccess
//            }
//        }
//    }
//}
//
//extension bottomCornerCircle {
//    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
//        let dataController: DataController
//
//
//        let backgroundColor: String
//
//        private let projectController: NSFetchedResultsController<Access>
//        @Published var access = [Access]()
//
//        init(dataController: DataController, backgroundColor: String) {
//            self.dataController = dataController
//            self.backgroundColor = backgroundColor
//
//
//            // Used to ensure MVVM where the request is
//            // able to be accessed by other Views
//            let request: NSFetchRequest<Access> = Access.fetchRequest()
//
//            request.predicate = NSPredicate(format: "backgroundColor = %d", backgroundColor)
//            request.sortDescriptors = [
//                NSSortDescriptor(keyPath: \Access.backgroundColor, ascending: true),
//            ]
//
//
//            projectController = NSFetchedResultsController(fetchRequest: request,
//                                                           managedObjectContext: dataController.container.viewContext,
//                                                           sectionNameKeyPath: nil,
//                                                           cacheName: nil
//            )
//
//            super.init()
//            projectController.delegate = self
//
//            do {
//                try projectController.performFetch()
//                access = projectController.fetchedObjects ?? []
//
//            } catch {
//                print("Failed to fetch our Recipes")
//            }
//
//        }
//
//        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//            if let newAccess = controller.fetchedObjects as? [Access] {
//                access = newAccess
//            }
//        }
//    }
//}
//
//extension centerCornerCircle {
//    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
//        let dataController: DataController
//
//
//        let backgroundColor: String
//
//        private let projectController: NSFetchedResultsController<Access>
//        @Published var access = [Access]()
//
//        init(dataController: DataController, backgroundColor: String) {
//            self.dataController = dataController
//            self.backgroundColor = backgroundColor
//
//
//            // Used to ensure MVVM where the request is
//            // able to be accessed by other Views
//            let request: NSFetchRequest<Access> = Access.fetchRequest()
//
//            request.predicate = NSPredicate(format: "backgroundColor = %d", backgroundColor)
//            request.sortDescriptors = [
//                NSSortDescriptor(keyPath: \Access.backgroundColor, ascending: true),
//            ]
//
//
//            projectController = NSFetchedResultsController(fetchRequest: request,
//                                                           managedObjectContext: dataController.container.viewContext,
//                                                           sectionNameKeyPath: nil,
//                                                           cacheName: nil
//            )
//
//            super.init()
//            projectController.delegate = self
//
//            do {
//                try projectController.performFetch()
//                access = projectController.fetchedObjects ?? []
//
//            } catch {
//                print("Failed to fetch our Recipes")
//            }
//
//        }
//
//        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//            if let newAccess = controller.fetchedObjects as? [Access] {
//                access = newAccess
//            }
//        }
//    }
//}
//
//extension smallCirclePattern {
//    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
//        let dataController: DataController
//
//
//        let backgroundColor: String
//
//        private let projectController: NSFetchedResultsController<Access>
//        @Published var access = [Access]()
//
//        init(dataController: DataController, backgroundColor: String) {
//            self.dataController = dataController
//            self.backgroundColor = backgroundColor
//
//
//            // Used to ensure MVVM where the request is
//            // able to be accessed by other Views
//            let request: NSFetchRequest<Access> = Access.fetchRequest()
//
//            request.predicate = NSPredicate(format: "backgroundColor = %d", backgroundColor)
//            request.sortDescriptors = [
//                NSSortDescriptor(keyPath: \Access.backgroundColor, ascending: true),
//            ]
//
//
//            projectController = NSFetchedResultsController(fetchRequest: request,
//                                                           managedObjectContext: dataController.container.viewContext,
//                                                           sectionNameKeyPath: nil,
//                                                           cacheName: nil
//            )
//
//            super.init()
//            projectController.delegate = self
//
//            do {
//                try projectController.performFetch()
//                access = projectController.fetchedObjects ?? []
//
//            } catch {
//                print("Failed to fetch our Recipes")
//            }
//
//        }
//
//        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//            if let newAccess = controller.fetchedObjects as? [Access] {
//                access = newAccess
//            }
//        }
//    }
//}
//
//
//
//
//
//
//
////redbackground
