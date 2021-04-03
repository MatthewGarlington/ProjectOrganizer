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
    
    var body: some View {
        NavigationView {
        ZStack {
            HomeBackGround()
            ScrollView {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: projectRows) {
                                ForEach(viewModel.projects, content: ProjectSummaryView.init)
                            }
                            .padding([.horizontal, .top])
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        VStack(alignment: .leading) {
                            ItemListView(title: "up next", items: viewModel.upNext)
                            ItemListView(title: "More to explore", items: viewModel.moreToExplore)
                        }
                        .padding(.horizontal)
                    }
                    .sheet(isPresented: $showAwardsModal) {
                        AwardsView()
                    }
                
                }
//
//                .toolbar {
//                    Button("Add Data", action: viewModel.addSampleData)
//                    }
            .toolbar {
                Button(action: {
                    self.showAwardsModal = true
                }, label: {
                   Image(systemName: "rosette")
                })
                }
            }
        .navigationBarTitle("Home")

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataController: .preview)
    }
}

struct HomeBackGround: View {
    var body: some View {
        ZStack {
            
            
            AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8472073078, green: 0.4155753255, blue: 0.6355627775, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]), center: .center, angle: .degrees(120))
            
            LinearGradient(gradient: Gradient(colors: [Color("Background 1").opacity(0.4), Color("Background 1").opacity(0.7)]), startPoint: .bottom, endPoint: .top)
            ZStack {
                Image("Blob4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(x: -150, y: -400)
                    .blendMode(.softLight)
                
                // Animation Rotates
                //                    .animation(Animation.easeOut(duration: 80).repeatForever(autoreverses: false))
                ZStack {
                    Image("Blob6")
                        .resizable()
                        .scaledToFit()
                        .blendMode(.softLight)
                    Image("Blob6")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .blendMode(.softLight)
                    Image("Blob6")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .blendMode(.softLight)
                    
                    
                    Image("Blob6")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350)
                        .blendMode(.softLight)
                    
                    
                }
                
                Image("Blob4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .offset(x: -150, y: -400)
                    // Added Rotation for the blob
                    //              .rotationEffect(Angle(degrees:  show ? 360 : 90))
                    .blendMode(.softLight)
                // Animation Rotates
                //                    .animation(Animation.easeOut(duration: 100).repeatForever(autoreverses: false))
                //
                
                Image("Blob4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .offset(x: -150, y: -400)
                    // Added Rotation for the blob
                    //              .rotationEffect(Angle(degrees:  show ? 360 : 90))
                    .blendMode(.softLight)
                // Animation Rotates
                //                    .animation(Animation.easeOut(duration: 120).repeatForever(autoreverses: false))
                
                Image("Blob4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .offset(x: -150, y: -400)
                    // Added Rotation for the blob
                    //              .rotationEffect(Angle(degrees:  show ? 360 : 90))
                    .blendMode(.softLight)
                // Animation Rotates
                //                    .animation(Animation.easeOut(duration: 140).repeatForever(autoreverses: false))
            }
            ZStack {
                
                
                Image("Blob4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .offset(x: -150, y: -400)
                    // Added Rotation for the blob
                    //              .rotationEffect(Angle(degrees:  show ? 360 : 90))
                    .blendMode(.softLight)
                // Animation Rotates
                //                    .animation(Animation.easeOut(duration: 100).repeatForever(autoreverses: false))
                
                
                Image("Blob4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .offset(x: -150, y: -400)
                    // Added Rotation for the blob
                    //              .rotationEffect(Angle(degrees:  show ? 360 : 90))
                    .blendMode(.softLight)
                //                    // Animation Rotates
                //                    .animation(Animation.easeOut(duration: 120).repeatForever(autoreverses: false))
                
                Image("Blob4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .offset(x: -150, y: -400)
                    // Added Rotation for the blob
                    //                    .rotationEffect(Angle(degrees:  show ? 360 : 90))
                    .blendMode(.softLight)
                // Animation Rotates
                //                    .animation(Animation.linear(duration: 140).repeatForever(autoreverses: false))
                //
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
