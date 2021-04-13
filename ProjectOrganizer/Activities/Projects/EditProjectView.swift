//
//  EditProjectView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//


import SwiftUI
import CoreHaptics

struct EditProjectView: View {
    @ObservedObject var project: Project
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var detail: String
   
    @State private var color: String
    @State private var showingDeleteConfirm = false
    @State private var mealsThisWeek = false

  

    @State private var engine = try? CHHapticEngine()
    
    
    // Added to make sure scaling down to smaller devices doesn't make the tappable items too small
    let colorColums = [
        GridItem(.adaptive(minimum: 44))
    ]
    
    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
     
        
    }
    
    var body: some View {
        Form {
            // section 1 (Basic Settings)
            Section(header: Text("Basic Settings")) {
                TextField("Recipe name", text: $title.onChange(update))
                TextField("Description of this Recipe", text: $detail.onChange(update))

            }
            // section 2 (Color picker)
            Section(header: Text("Custom recipe color")) {
                LazyVGrid(columns: colorColums) {
                    ForEach(Project.colors, id: \.self, content: colorButton)
                }
                .padding(.vertical)
            }
            // section 3
            Section(footer: Text("Closing a recipe moves it from the to get to already bought tab, deleting it removes the recipe entirely")) {
                Button(project.closed ? "Add to Shopping List" : "Move To Purchased") {

                    toggleClosed()

//                    if !project.closed {
//                        project.mealsThisWeek = true
//                    }
                }
                Button(project.saved ? "Remove from Saved Recipes" : "Move to Saved Recipes") {
                    project.saved.toggle()
                }

                Button(project.mealsThisWeek ? "Remove From Meals This Week Tab" : "Move To Meals This Week Tab") {
                    project.mealsThisWeek.toggle()
                }
         
                Button("Delete this recipe") {
                    showingDeleteConfirm.toggle()
                }
                .accentColor(.red)
            }
        }
        .navigationTitle("Edit Recipe")
        .onDisappear() {
            project.mealsThisWeek = true
            dataController.save()

        }
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete Recipe?"),
                  message: Text("Are you sure you want to delete this recipe? You will also delete all the ingredients within the recipe it contains."),
                  primaryButton: .default(Text("Delete"),
                                          action: delete),
                  secondaryButton: .cancel())
        }
    }
    
    func update() {
        project.title = title
        project.detail = detail
        project.color = color

        
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }

    func toggleClosed() {
            project.closed.toggle()

            if project.closed {
               // Trigger Custom Haptics
                do {
                    try? engine?.start()

                    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
                    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)

                    let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
                    let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)

                    let parameter = CHHapticParameterCurve(
                        parameterID: .hapticIntensityControl,
                        controlPoints: [start, end],
                        relativeTime: 0
                    )
                    // Play the Haptic that was set up above

                    let event1 = CHHapticEvent(
                        eventType: .hapticTransient,
                        parameters: [intensity, sharpness],
                        relativeTime: 0
                    )

                    let event2 = CHHapticEvent(
                        eventType: .hapticContinuous,
                        parameters: [intensity, sharpness],
                        relativeTime: 0.125,
                        duration: 1
                    )

                    let pattern = try CHHapticPattern(events: [event1, event2],
                                                      parameterCurves: [parameter]
                    )

                    let player = try engine?.makePlayer(with: pattern)
                    try player?.start(atTime: 0)
                } catch {

                    // playing haptics didn't work
                }

        }
    }
    
    func colorButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6)
            if item == color {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            color = item
            update()
        }
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}

