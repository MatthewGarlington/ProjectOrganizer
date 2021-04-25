//
//  MealsThisWeekView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/9/21.
//

import SwiftUI

struct MealPickerView: View {
    @State private var selectedWeekday = "Monday"
    @State private var selectedMeal = "Dinner"
    let meal = ["Breakfast", "Lunch" ,"Dinner"]
    let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var body: some View {
        Form {
            Picker("Week Days", selection: $selectedWeekday) {
                ForEach(weekDays, id: \.self) {
                    Text($0)
                }
            }

            Picker("Meal", selection: $selectedMeal) {
                ForEach(meal, id: \.self) {
                    Text($0)
                }
            }
            Text("\(selectedWeekday)")
            Text("\(selectedMeal)")
        }

            .navigationBarTitle("Pick a Day for this Meal")
    }
}

struct MealPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealPickerView()
        }
    }
}
