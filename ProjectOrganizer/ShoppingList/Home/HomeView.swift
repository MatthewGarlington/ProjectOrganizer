//
//  HomeView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
   
    static let tag: String? = "Home"
    @StateObject var viewModel: ViewModel
    
    
    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }
    
    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
   
    
    @State var show = false
    @State var showAwardsModal = false
    @State var waveEffect = false
    
    var body: some View {
        NavigationView {

        ZStack {

           HomeBackGroundView()
            .rotationEffect(Angle(degrees: waveEffect ? 360 : 0))
            .offset(y: waveEffect ? 200 : 0)
            .animation(.spring())
            
          
            
            ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Quick View")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                            
                            // For Simulator to add Example data
                            // Replace Awards button with Add Data
                            // Button below
                            
          //                  Button("Add Data", action: viewModel.addSampleData)
                            Button(action: {
                                self.showAwardsModal = true
                            }, label: {

                                ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.5))
                                    .frame(width: 75, height: 75)
                                    .overlay(
                                        Circle()
                                             .stroke(lineWidth: 4)
                                     )



                               Image(systemName: "rosette")
                                .font(.largeTitle)

                                }
                            })
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading) {
                            ItemListView(title: "To Get", items: viewModel.moreToExplore, waveEffect: $waveEffect)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .sheet(isPresented: $showAwardsModal) {
                        AwardsView()
                    }


                
                }

        }


        .navigationBarHidden(true)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataController: .preview)
    }
}



