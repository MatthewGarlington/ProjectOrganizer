//
//  RecipesForTheWeekView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/9/21.
//

import SwiftUI


struct RecipesForTheWeekView: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    @EnvironmentObject var dataController: DataController



    var weekMealsList: some View {
        VStack {

            List {

                    Section(header: Text("Not Assigned Yet")) {
                        ForEach(viewModel.projects) { project in
                            NavigationLink(
                                destination: EditRecipeForThisWeek(project: project),
                                label: {
                                    HStack {
                                        Text("\(project.title ?? "")")
                                        Text("\(project.day ?? "")")

                                    }
                                   
                                })
                        }
                    }

                SundayListSection(dataController: dataController, sundayAssignment: true)


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

                    weekMealsList
                }
            }


            .navigationBarTitle("Meals This Week")


            SelectSomethingView()
        }
    }

    init(dataController: DataController, mealsThisWeek: Bool) {
        let viewModel = ViewModel(dataController: dataController, mealsThisWeek: mealsThisWeek)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct RecipesForTheWeekView_Previews: PreviewProvider {

    static var previews: some View {
        RecipesForTheWeekView(dataController: DataController.preview, mealsThisWeek: false)
    }
}

struct SundayListSection: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    let noMealShown = "No Meal Shown For This Day"

    let meals = [
        "Breakfast", "Lunch", "Dinner"
    ]

    var body: some View {

        Section(header: Text("Sunday")) {
                ForEach(viewModel.projects, id: \.self) { project in
                    NavigationLink(
                        destination: EditRecipeForMealView(project: project),
                        label: {
                            HStack {
                                Text("Breakfast: \(project.title ?? "")")

                            }
                        })
            }
        }

    }

    init(dataController: DataController, sundayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, sundayAssignment: sundayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

