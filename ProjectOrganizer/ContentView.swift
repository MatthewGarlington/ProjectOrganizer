//
//  ContentView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI


/// Adds  TabView that allows the user to select between Home, Open Projects, Closed Projects,
/// and awards that the user has earned
struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?
    @EnvironmentObject var dataController: DataController
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(ciColor: .clear)
     }
    
    var body: some View {
        TabView(selection: $selectedView) {
            HomeView(dataController: dataController)
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProjectsView(dataController: dataController, showClosedProjects: false)
                .tag(ProjectsView.openTag)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Shopping List")
                }
            ProjectsView(dataController: dataController, showClosedProjects: true)
                .tag(ProjectsView.closedTag)
                .tabItem {
                    Image(systemName: "checkmark")
                    Text("Purchased")
                }
            SavedRecipeView(dataController: dataController, showSavedProjects: true)
                .tag(SavedRecipeView.savedTag)
                .tabItem {
                    Image(systemName: "star")
                    Text("Saved Recipes")
                }
            RecipesForTheWeekView(dataController: dataController, mealsThisWeek: true)
                .tag(RecipesForTheWeekView.weekList)
                .tabItem {
                    Image(systemName: "calendar.circle")
                    Text("Week")
                    }
                }
        .accentColor(Color(#colorLiteral(red: 0.5910183787, green: 0.8180559874, blue: 0.7196184993, alpha: 1)))
        }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
