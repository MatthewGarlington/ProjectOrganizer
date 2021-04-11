//
//  EditRecipeForMealView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/10/21.
//


import SwiftUI
import CoreHaptics

struct EditRecipeForMealView: View {
    @ObservedObject var project: Project

    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode

    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var meal: String
    @State private var showingDeleteConfirm = false
    @State private var showingClearConfirm = false

    @State private var engine = try? CHHapticEngine()


    let meals = [
        "Breakfast", "Lunch", "Dinner"
    ]



    // Added to make sure scaling down to smaller devices doesn't make the tappable items too small
    let colorColums = [
        GridItem(.adaptive(minimum: 44))
    ]

    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
        _meal = State(wrappedValue: project.projectMeal)
    }

    var body: some View {
        Form {
            // section 1 (Basic Settings)
            Section(header: Text("Basic Settings")) {
                TextField("Recipe name", text: $title.onChange(update))
                TextField("Description of this Recipe", text: $detail.onChange(update))


                Picker("Meal Type", selection: $meal.onChange(update)) {
                    ForEach(meals, id: \.self) {
                        Text($0)
                    }
                }
            }



            // section 4
            Section(header: Text("Moving to the Shopping List moves The Recipe to the Shopping List tab")) {
                Button(project.closed ? "Move to Shopping List" : "Move To Purchased") {
                    toggleClosed()
                }

                Button(action: {
                    project.mealsThisWeek = true
                    project.sundayAssignment = false
                    project.mondayAssignment = false
                    project.tuesdayAssignment = false
                    project.wednesdayAssignment = false
                    project.thursdayAssignment = false
                    project.fridayAssignment = false
                    project.saturdayAssignment = false

                }, label: {

                    HStack {
                        Text(project.mealsThisWeek ? "Moved to Unassigned": "Move to Unassigned")
                        Spacer()
                        Image(systemName: project.mealsThisWeek ?  "checkmark.circle" : "circle")
                    }
                    .foregroundColor(Color(project.mealsThisWeek ? .secondaryLabel : .black))

                }
                )

            }
                Section(footer: Text("Clearing removes the recipe from the Shopping List Tab, deleting it removes the recipe entirely")) {

                    Button("Clear this recipe") {
                        showingClearConfirm.toggle()
                    }
                    .accentColor(.secondary)

                    Button("Delete this recipe") {
                    showingDeleteConfirm.toggle()
                }
                .accentColor(.red)
            }
        }
        .navigationTitle("Edit Recipe")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete Recipe?"),
                  message: Text("Are you sure you want to delete this recipe? You will also delete all the ingredients within the recipe it contains."),
                  primaryButton: .default(Text("Delete"),
                                          action: delete),
                  secondaryButton: .cancel())
        }
        .alert(isPresented: $showingClearConfirm) {
            Alert(title: Text("Clear Recipe from List?"),
                  message: Text("Are you sure you want to remove this meal from this Week's Meals? This action will not remove the Recipe or ingredients entirely"),
                  primaryButton: .default(Text("Clear"),
                                          action: clear),
                  secondaryButton: .cancel())
        }
    }



    func clear() {
        project.sundayAssignment = false
        project.mondayAssignment = false
        project.tuesdayAssignment = false
        project.wednesdayAssignment = false
        project.thursdayAssignment = false
        project.fridayAssignment = false 
        presentationMode.wrappedValue.dismiss()
    }

    func update() {
        project.title = title
        project.detail = detail
        project.color = color
        project.meal = meal
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

struct EditRecipeForMealView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeForMealView(project: Project.example)
    }
}



