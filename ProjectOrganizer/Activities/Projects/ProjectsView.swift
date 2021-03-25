//
//  ProjectsView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingSortOrder = false
    @State private var sortOrder = Item.SortOrder.optimized
    
    let showClosedProjects: Bool
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
        ], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
        
    }
    
    
    var projectsList: some View {
        
    
        ZStack {
 
        List {
            ForEach(projects.wrappedValue) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: sortOrder)) { item in
                        ItemRowView(project: project, item: item)
                 
                    }
               
                    // delete the items without messing up the sorted order
                    .onDelete { offsets in
                        delete(offsets, from: project)
                    }
                    
                 
                    if showClosedProjects == false {
                        Button {
                            addItem(to: project)
                        } label: {
                            Label("Add new Item", systemImage: "plus")
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
            if showClosedProjects == false {
                Button(action: addProject) {
                    Label("Add Project", systemImage: "plus")
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
                if projects.wrappedValue.isEmpty {
                    Text("There's nothing here right now")
                        .foregroundColor(.secondary)
                } else {
                    projectsList
                }
            }
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort Items"), message: Text("Sort items"), buttons: [
                    .default(Text("Optimized")) { sortOrder = .optimized},
                    .default(Text("Creation Date")) { sortOrder = .creationDate },
                    .default(Text("Title")) { sortOrder = .title }
                ])
            }
            SelectSomethingView()
        }
    }
    
    func addProject() {
        withAnimation {
            let project = Project(context: managedObjectContext)
            project.closed = false
            project.creationDate = Date()
            dataController.save()
        }
    }
    
    func addItem(to project: Project) {
        withAnimation {
            let item = Item(context: managedObjectContext)
            item.project = project
            item.creationDate = Date()
            dataController.save()
        }
    }
    
    func delete(_ offsets: IndexSet, from project: Project) {
        let allItems = project.projectItems(using: sortOrder)
        for offset in offsets {
            let item = allItems[offset]
            dataController.delete(item)
        }
        dataController.save()
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
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
