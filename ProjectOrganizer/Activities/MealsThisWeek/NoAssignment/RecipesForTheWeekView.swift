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
                                            .foregroundColor(Color(project.color ?? "Green"))


                                    }
                                   
                                })
                        }
                    }

                SundayListSection(dataController: dataController, sundayAssignment: true)
                MondayListSection(dataController: dataController, mondayAssignment: true)
                TuesdayListSection(dataController: dataController, tuesdayAssignment: true)
                WednesdayListSection(dataController: dataController, wednesdayAssignment: true)
                ThursdayListSection(dataController: dataController, thursdayAssignment: true)
                FridayListSection(dataController: dataController, fridayAssignment: true)
                SaturdayListSection(dataController: dataController, saturdayAssignment: true)

                }
            }

        }








    var body: some View {
        NavigationView {
            Group {


                    weekMealsList
            }


            .navigationBarTitle("Meals This Week")

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
        }

    }

    init(dataController: DataController, sundayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, sundayAssignment: sundayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct MondayListSection: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    let noMealShown = "No Meal Shown For This Day"

    let meals = [
        "Breakfast", "Lunch", "Dinner"
    ]

    var body: some View {
        Section(header: Text("Monday")) {
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
        }

    }

    init(dataController: DataController, mondayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, mondayAssignment: mondayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}


struct TuesdayListSection: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    let noMealShown = "No Meal Shown For This Day"

    let meals = [
        "Breakfast", "Lunch", "Dinner"
    ]

    var body: some View {
        Section(header: Text("Tuesday")) {
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
        }

    }

    init(dataController: DataController, tuesdayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, tuesdayAssignment: tuesdayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}


struct WednesdayListSection: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    let noMealShown = "No Meal Shown For This Day"

    let meals = [
        "Breakfast", "Lunch", "Dinner"
    ]

    var body: some View {
        Section(header: Text("Wednesday")) {
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
        }

    }

    init(dataController: DataController, wednesdayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, wednesdayAssignment: wednesdayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct ThursdayListSection: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    let noMealShown = "No Meal Shown For This Day"

    let meals = [
        "Breakfast", "Lunch", "Dinner"
    ]

    var body: some View {
        Section(header: Text("Thursday")) {
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
        }

    }

    init(dataController: DataController, thursdayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, thursdayAssignment: thursdayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct FridayListSection: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    let noMealShown = "No Meal Shown For This Day"

    let meals = [
        "Breakfast", "Lunch", "Dinner"
    ]

    var body: some View {
        Section(header: Text("Friday")) {
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
        }

    }

    init(dataController: DataController, fridayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, fridayAssignment: fridayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct SaturdayListSection: View {
    static let weekList: String? = "Meals This Week"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false


    var body: some View {
        Section(header: Text("Saturday")) {
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
        }

    }

    init(dataController: DataController, saturdayAssignment: Bool) {
        let viewModel = ViewModel(dataController: dataController, saturdayAssignment: saturdayAssignment)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}



