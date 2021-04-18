//
//  ProjectHeaderView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

struct ProjectHeaderView: View {
    @ObservedObject var project: Project
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)
                    .foregroundColor(Color(project.projectColor))
                    .font(.title)
                    .bold()
//                ProgressView(value: project.completionAmount)
//                    .accentColor(Color(project.projectColor))
            }
            Spacer()
            
            NavigationLink(destination: EditProjectView(project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }

        }
        .padding(.bottom, 10)
        .padding()
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
