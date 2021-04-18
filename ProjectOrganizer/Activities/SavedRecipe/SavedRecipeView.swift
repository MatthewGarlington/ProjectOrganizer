//
//  SavedRecipeView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/4/21.
//

import SwiftUI

struct SavedRecipeView: View {
    static let savedTag: String? = "Saved Recipes"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false



    var savedProjectsList: some View {


        ZStack {

            VStack {
                List {
                ForEach(viewModel.projects) { project in
                    Section(header: SavedRecipeHeaderView(project: project)) {
                        ForEach(project.projectItems(using: viewModel.sortOrder)) { item in
                            SavedItemRow(project: project, item: item)

                        }

                        // delete the items without messing up the sorted order
                        .onDelete { offsets in
                            viewModel.delete(offsets, from: project)
                        }
                    }
                    .listStyle(InsetListStyle())

                }

                }
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

                    savedProjectsList
                }
            }


            .navigationBarTitle("Saved Recipes")
       


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

    init(dataController: DataController, showSavedProjects: Bool) {
        let viewModel = ViewModel(dataController: dataController, showSavedProjects: showSavedProjects)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct SavedRecipeView_Previews: PreviewProvider {

    static var previews: some View {
        SavedRecipeView(dataController: DataController.preview, showSavedProjects: false)
    }
}


