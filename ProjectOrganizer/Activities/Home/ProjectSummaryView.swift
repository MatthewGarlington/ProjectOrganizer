//
//  ProjectSummaryView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

struct ProjectSummaryView: View {
    @ObservedObject var project: Project
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(project.projectItems.count) items")
                .font(.caption)
                .foregroundColor(.secondary)
            Text(project.projectTitle)
                .font(.title)
            ProgressView(value: project.completionAmount)
                .accentColor(Color(project.projectColor))
        }
        .padding()
        .background(BlurView(style: .systemMaterialLight))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5)
        .padding(5)
    }
}

struct ProjectSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSummaryView(project: Project.example)
    }
}
