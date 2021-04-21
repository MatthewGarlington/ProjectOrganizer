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
    @EnvironmentObject var dataController: DataController
    @StateObject var store = UserSettings()

    



    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @State var show = true
    @State var showAwardsModal = false
    @State var waveEffect = false
    @State var rotateEffect = false
    @State var showSettingsModal = false
    @State var backgroundColor = "Light Blue"
    @State var red = 2
    @State private var tapped = 0
    let delaySeconds = 0.7
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {

                    leftCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: -150, y: -400)
                    bottomCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: -150, y: 400)
                    centerCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 0, y: 0)
                    bottomCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 200, y: -450)

                    bottomCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 175, y: 390)

            }

                    .environmentObject(store)
                ZStack {
                smallCirclePattern()
                    .scaleEffect(tapped > 0 ? 0.90 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                    .offset(x: -50, y: -150)
                smallLightCircle()
                    .scaleEffect(tapped > 0 ? 0.90 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                    .offset(x: 100, y: 150)
                smallLightCircle()
                    .scaleEffect(tapped > 0 ? 0.90 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                    .offset(x: -125, y: -250)
                smallCirclePattern()
                    .scaleEffect(tapped > 0 ? 0.90 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                    .offset(x: 150, y: 275)

                    smallCirclePattern()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: -75, y: 100)
                    smallLightCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: -150, y: 200)
                    smallLightCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 175, y: -250)
                    smallCirclePattern()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 100, y: -150)

                }
                    .environmentObject(store)

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

                            Button(action: {
                                self.showSettingsModal = true
                            }, label: {

                                ZStack {
                                    Circle()
                                        .fill(Color.black.opacity(0.5))
                                        .frame(width: 75, height: 75)
                                        .overlay(
                                            Circle()
                                                .stroke(lineWidth: 4)
                                        )
                                    Image(systemName: "gear")
                                        .font(.largeTitle)
                                }
                            })
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading) {
                            ItemListView(title: "To Get", items: viewModel.moreToExplore, waveEffect: $waveEffect, rotateEffect: $rotateEffect, tapped: $tapped)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .sheet(isPresented: $showAwardsModal) {
                        AwardsView()
                    }
                    .sheet(isPresented: $showSettingsModal) {
                       UserDefaultsView()
                        .environmentObject(store)


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



