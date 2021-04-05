//
//  SavedRecipeHeaderView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/4/21.
//

import SwiftUI

struct SavedRecipeHeaderView: View {
    @ObservedObject var project: Project
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)
                    .foregroundColor(Color(project.projectColor))
                    .font(.title)
                    .bold()
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }
            Spacer()

            NavigationLink(destination: EditSavedRecipeView(project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }
        .padding(.bottom, 10)
        .padding()
    }
}

struct SavedRecipeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRecipeHeaderView(project: Project.example)
    }
}
