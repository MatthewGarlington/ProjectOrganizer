//
//  ProjectsView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "Shopping List"
    static let closedTag: String? = "Purchased"
    
    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    
    
    
    var projectsList: some View {
        ZStack {
 
            VStack {
                List {
                ForEach(viewModel.projects) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(project.projectItems(using: viewModel.sortOrder)) { item in
                            ItemRowView(project: project, item: item)
                        }
                        // delete the items without messing up the sorted order
                        .onDelete { offsets in
                            viewModel.delete(offsets, from: project)
                        }


                        if viewModel.showClosedProjects == false {
                            Button {
                                withAnimation {
                                viewModel.addItem(to: project)

                                }
                            } label: {
                                Label("Add New Ingredient", systemImage: "plus")
                            }
                        }
                    }
                    .listStyle(InsetListStyle())

                }
                }
            }
        }
    }
       
        
    
    
    var addProjectToolbarItem: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            if viewModel.showClosedProjects == false {
                Button {
                    withAnimation {
                        viewModel.addProject()
                        
                    }
                    } label: {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
    }
    
    var sortOrderToolbarItem: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.projects.isEmpty {
                    Text("There's nothing here right now")
                        .foregroundColor(.secondary)
                } else {

                    projectsList
                }
            }


            .navigationBarTitle(viewModel.showClosedProjects ? "Purchased" : "Shopping List")


            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort Items"), message: Text("Sort items"), buttons: [
                    .default(Text("Optimized")) { viewModel.sortOrder = .optimized},
                    .default(Text("Creation Date")) { viewModel.sortOrder = .creationDate },
                    .default(Text("Title")) { viewModel.sortOrder = .title }
                ])
            }
            SelectSomethingView()
        }
    }
    
    init(dataController: DataController, showClosedProjects: Bool) {
        let viewModel = ViewModel(dataController: dataController, showClosedProjects: showClosedProjects)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct ProjectsView_Previews: PreviewProvider {
 
    static var previews: some View {
        ProjectsView(dataController: DataController.preview, showClosedProjects: false)
    }
}
 


