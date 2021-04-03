//
//  ProjectsView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "To Get"
    static let closedTag: String? = "Already Bought"
    
    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false
    
    
    
    var projectsList: some View {
        
    
        ZStack {
 
        List {
            ForEach(viewModel.projects) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: viewModel.sortOrder)) { item in
                        ItemRowView(project: project, item: item)
                 
                    }
               
                    // delete the items without messing up the sorted order
                    .onDelete { offsets in
                        viewModel.delete(offsets, from: project)
                    }
                    
                 
                    if viewModel.showClosedProjects == false {
                        Button {
                            withAnimation {
                            viewModel.addItem(to: project)
                            }
                        } label: {
                            Label("Add New Ingredient", systemImage: "plus")
                        }
                        
                    }
                    
                }
                .listStyle(InsetListStyle())
               
            }
         
        }
        }
     
    }
       
        
    
    
    var addProjectToolbarItem: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            if viewModel.showClosedProjects == false {
                Button {
                    withAnimation {
                        viewModel.addProject()
                    }
                    } label: {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
    }
    
    var sortOrderToolbarItem: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.projects.isEmpty {
                    Text("There's nothing here right now")
                        .foregroundColor(.secondary)
                } else {
                    projectsList
                }
            }
            .navigationTitle(viewModel.showClosedProjects ? "Already Bought" : "To Get")
            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort Items"), message: Text("Sort items"), buttons: [
                    .default(Text("Optimized")) { viewModel.sortOrder = .optimized},
                    .default(Text("Creation Date")) { viewModel.sortOrder = .creationDate },
                    .default(Text("Title")) { viewModel.sortOrder = .title }
                ])
            }
            SelectSomethingView()
        }
    }
    
    init(dataController: DataController, showClosedProjects: Bool) {
        let viewModel = ViewModel(dataController: dataController, showClosedProjects: showClosedProjects)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct ProjectsView_Previews: PreviewProvider {
 
    static var previews: some View {
        ProjectsView(dataController: DataController.preview, showClosedProjects: false)
    }
}
 

struct ProjectsBackGround: View {
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
                        .blendMode(.colorBurn)
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
                    .blendMode(.darken)
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
                    .blendMode(.darken)
                // Animation Rotates
                //                    .animation(Animation.easeOut(duration: 120).repeatForever(autoreverses: false))
                
                Image("Blob4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .offset(x: -150, y: -400)
                    // Added Rotation for the blob
                    //              .rotationEffect(Angle(degrees:  show ? 360 : 90))
                    .blendMode(.darken)
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
