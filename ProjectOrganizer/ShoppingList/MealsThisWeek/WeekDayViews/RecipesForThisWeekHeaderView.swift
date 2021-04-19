//
//  RecipesForThisWeekHeaderView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/9/21.
//

import SwiftUI


struct RecipesForThisWeekHeaderView: View {
    @ObservedObject var project: Project
    @State private var selectedWeekday = "No Day Selected"


    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.day ?? "No Day Selected")
                    .foregroundColor(Color(project.projectColor))
                    .font(.title)
                    .bold()
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }
            Spacer()

            NavigationLink(destination: EditRecipeForThisWeek(project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }
        .padding(.bottom, 10)
        .padding()
    }
}

struct RecipesForThisWeekHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesForThisWeekHeaderView(project: Project.example)
    }
}

