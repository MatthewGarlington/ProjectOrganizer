//
//  RecipesForTheWeekView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/9/21.
//

import SwiftUI

struct RecipesForTheWeekView: View {
    let meal = ["Breakfast", "Lunch" ,"Dinner"]
    let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var body: some View {
        VStack {
            Text("Meals for the Week")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            ScrollView {
                VStack {
                    ForEach(weekDays, id: \.self) { num in
                        Text(num)
                            .bold()
                            .font(.title)
                            .underline()
                        Spacer()
                            .frame(width: 350, height: 100)
                            .background(Color.black.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous), style: FillStyle())
                            .overlay(
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Breakfast:")
                                            .bold()
                                        Text("Meal \(num)")
                                    }

                                    HStack {
                                        Text("Lunch:")
                                            .bold()
                                        Text("Meal \(num)")
                                    }

                                    HStack {
                                        Text("Dinner:")
                                            .bold()
                                        Text("Meal \(num)")
                                    }
                                }
                            )
                            .padding()
                    }
                }
            }
        }
    }
}

struct RecipesForTheWeekView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesForTheWeekView()
    }
}
