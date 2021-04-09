//
//  MealsThisWeekView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/9/21.
//

import SwiftUI

struct MealPickerView: View {
    @State private var selectedWeekday = "Monday"
    let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var body: some View {
        Form {
            Picker("Week Days", selection: $selectedWeekday) {
                ForEach(weekDays, id: \.self) {
                    Text($0)
                }
            }
            Text("\(selectedWeekday)")
        }

            .navigationBarTitle("Dishes for the Week")
    }
}

struct MealPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealPickerView()
        }
    }
}
