//
//  SavedRecipesView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/3/21.
//

import SwiftUI

struct SavedRecipesView: View {
    static let openTag: String? = "To Get"
    static let closedTag: String? = "Already Bought"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
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
            .navigationBarTitle("Saved Recipes")
        }
    }

    var projectsList: some View {


        ZStack {

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
    init(dataController: DataController, showClosedProjects: Bool) {
        let viewModel = ViewModel(dataController: dataController, showClosedProjects: showClosedProjects)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

}



struct SavedRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRecipesView(dataController: DataController.preview, showClosedProjects: false)
    }
}
