//
//  ProjectOrganizerApp.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

@main
struct ProjectOrganizerApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // For Swift to read Core Data values
                .environment(\.managedObjectContext, dataController.container.viewContext)
                // For Our own code to read Core Data values
                .environmentObject(dataController)
                // Save the app when the user loses focus and this app is no longer presenting
                .onReceive(
                    // Automatically save when we detect that we are no longer
                    // the foreground app. Use this rather than the scene phase
                    // API so we can port to macOS, where scene phase won't detect
                    // our app losing focus as of macOS 11.1
                    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                    perform: save)
        }
    }
    
    func save(_ note: Notification) {
        dataController.save()
        
    }
}
