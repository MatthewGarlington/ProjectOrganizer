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
                    .onMove(perform: move)
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


    var body: some View {
        NavigationView {
            Group {


                weekMealsList
            }


            .navigationBarTitle("Meals This Week")
            .navigationBarItems(trailing: EditButton())

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






