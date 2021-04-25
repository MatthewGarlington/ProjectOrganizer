//
//  AwardsView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import Foundation
import Combine
import SwiftUI

struct TitleBarTwo: View {

    var body: some View {
        HStack {
            Text("Awards")
                .bold()
                .font(.largeTitle)


            Spacer()
        }
        .padding([.horizontal, .top])
    }
}


struct AwardsView: View {
  //  static let tag: String? = "Awards"
    
    @EnvironmentObject var dataController: DataController
    @State private var selectedAward = Award.example
    @State private var showingAwardDetail = false
    var colums: [GridItem] {
        [GridItem(.fixed(40), spacing: 20),
                    GridItem(.fixed(40), spacing: 20),
                    GridItem(.fixed(40), spacing: 20)]
    }
    
    var body: some View {
        NavigationView {
                LazyVGrid(columns: colums) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            showingAwardDetail = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(color(for: award))
                        }
                    }
                }
            .navigationTitle("Awards")
        }
        .alert(isPresented: $showingAwardDetail, content: getAwardAlert)
    }
    
    func color(for award: Award) -> Color {
        dataController.hasEarned(award: award) ? Color(award.color) : Color.secondary.opacity(0.5)
        
    }
    
    func getAwardAlert() -> Alert {
        
        if dataController.hasEarned(award: selectedAward) {
            return Alert(title: Text("Unlocked \(selectedAward.name)"),
                         message: Text("\(selectedAward.description)"),
                         dismissButton: .default(Text("Ok")))
        } else {
            return Alert(title: Text("Locked"), message: Text(selectedAward.description),
                         dismissButton: .default(Text("Ok")))
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}

