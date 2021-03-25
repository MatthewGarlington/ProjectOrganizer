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
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(entity: Project.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: true)],
                  predicate: NSPredicate(format: "closed = false")) var projects: FetchedResults<Project>
    let items: FetchRequest<Item>
    
    init() {
        // Construct a fetch request to show the 10 highest-priority,
        // incomplete items from open projects
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let completedPredicate = NSPredicate(format: "completed = false")
        let openPredicate = NSPredicate(format: "project.closed = false")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [completedPredicate, openPredicate])
        request.predicate = compoundPredicate
      
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.priority, ascending: false)
        ]
        
        request.fetchLimit = 10
        items = FetchRequest(fetchRequest: request)
    }
    
    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }
    
    @State var show = false
    
    var body: some View {
        NavigationView {
        ZStack {
            HomeBackGround()
            ScrollView {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: projectRows) {
                                ForEach(projects, content: ProjectSummaryView.init)
                            }
                            .padding([.horizontal, .top])
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        VStack(alignment: .leading) {
                            ItemListView(title: "up next", items: items.wrappedValue.prefix(3))
                            ItemListView(title: "More to explore", items: items.wrappedValue.dropFirst(3))
                        }
                        .padding(.horizontal)
                    }
                }
              
             
                .toolbar {
                    Button("Add Data"){
                        dataController.deleteAll()
                        try? dataController.createSampleData()
                        
                    }
               
            }
           
        }
        .navigationBarTitle("Home")
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DataController.preview)
    }
}

struct HomeBackGround: View {
    var body: some View {
        ZStack {
            
            
            AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8472073078, green: 0.4155753255, blue: 0.6355627775, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]), center: .center, angle: .degrees(120))
            
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.3)]), startPoint: .bottom, endPoint: .top)
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
