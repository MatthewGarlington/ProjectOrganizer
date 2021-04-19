//
//  SundayListSectionView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/19/21.
//

import SwiftUI

struct SundayListSection: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false


    var body: some View {

        Section(header: Text("Sunday")) {
            ForEach(viewModel.projects, id: \.self) { project in
                NavigationLink(
                    destination: EditRecipeForMealView(project: project),
                    label: {
                        HStack {
                            Text("\(project.meal ?? "Breakfast"):")
                                .bold()
                            Text(" \(project.title ?? "")")
                                .foregroundColor(Color(project.color ?? "Green"))
                        }

                    })


            }

            .onMove(perform: move)
        }

    }

    func move(from source: IndexSet, to destination: Int) {
        // Make an array of items from fetched results
        var revisedItems: [Project] = viewModel.projects.map{ $0 }

        // change the order of the items in the array
        revisedItems.move(fromOffsets: source, toOffset: destination)

        // update the userOrder attribute in revisedItems to
        // persist the new order. This is done in reverse order
        // to minimize changes to the indices.
        for reverseIndex in stride( from: revisedItems.count - 1,
                                    through: 0,
                                    by: -1 )
        {
            revisedItems[reverseIndex].position =
                Int16(reverseIndex)
        }
    }


    init(dataController: DataController, sundayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, sundayAssignment: sundayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

