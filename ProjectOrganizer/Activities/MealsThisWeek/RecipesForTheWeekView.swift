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

    let noMealShown = "No Meal Shown For This Day"
    let weekDays = [
                           "Sunday",
                           "Monday",
                           "Tuesday",
                           "Wednesday",
                           "Thursday",
                           "Friday",
                           "Saturday"]
    let meals = [ "Breakfast", "Lunch", "Dinner"
    ]



    var weekMealsList: some View {



        VStack {

            List {


                    Section(header: Text("Not Assigned Yet")) {
                        ForEach(viewModel.projects) { project in
                        NavigationLink(
                            destination: EditRecipeForThisWeek(project: project),
                            label: {
                                Text("\(project.title ?? "")")
                            })

                    }
                }
                ForEach(weekDays.indices, id: \.self) { num in
                    Section(header: Text("\(weekDays[num])")) {
                        ForEach(meals.indices, id: \.self) { meal in
                            Section(header: Text("\(meals[meal])")) {
                            }

                        }
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

