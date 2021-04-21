//
//  HomeSettingsView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/19/21.
//

import SwiftUI

struct HomeSettingsView: View {

    @ObservedObject var project: Project

    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode



    // Added to make sure scaling down to smaller devices doesn't make the tappable items too small
    let colorColums = [
        GridItem(.adaptive(minimum: 44))
    ]
    
    init(project: Project) {
        self.project = project
 


    }
    var body: some View {
        Form {
            Section(header: Text("Turn Color to Red")) {
                Button("Project Red" ) {

                 //   project.redbackground.toggle()
                    dataController.save()

                }
            }
        }
       

    }


}

struct HomeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSettingsView(project: Project.example)
    }
}
