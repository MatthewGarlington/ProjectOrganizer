//
//  EditRecipeForThisWeek.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/9/21.
//

import SwiftUI
import CoreHaptics

struct EditRecipeForThisWeek: View {
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


    // Added to make sure scaling down to smaller devices doesn't make the tappable items too small
    let colorColums = [
        GridItem(.adaptive(minimum: 44))
    ]

    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
        _meal = State(wrappedValue: project.meal ?? "Breakfast")
    }

    var body: some View {
        Form {
            // section 1 (Basic Settings)
            Section(header: Text("Basic Settings")) {
                TextField("Recipe name", text: $title.onChange(update))
                TextField("Description of this Recipe", text: $detail.onChange(update))

            }
            // Section 3, Choose a Day

            Section(header: Text("Choose a Day for the Meal to be made on this week.")) {

                if project.sundayAssignment {

                    Toggle(isOn: $project.sundayAssignment) {
                        Text("Sunday")
                    }
                }
                else if project.mondayAssignment {
                    Toggle(isOn: $project.mondayAssignment) {
                        Text("Monday")
                    }
                }
                else if project.tuesdayAssignment {

                    Toggle(isOn: $project.tuesdayAssignment) {
                        Text("Tuesday")
                    }
                }
                else if project.wednesdayAssignment {

                    Toggle(isOn: $project.wednesdayAssignment) {
                        Text("Wednesday")
                    }
                }

                else if project.thursdayAssignment {

                    Toggle(isOn: $project.thursdayAssignment) {
                        Text("Thursday")
                    }
                }

                else if project.fridayAssignment {

                    Toggle(isOn: $project.fridayAssignment) {
                        Text("Friday")
                    }
                }
                else if project.saturdayAssignment {

                    Toggle(isOn: $project.saturdayAssignment) {
                        Text("Saturday")
                    }

                } else {
                    Toggle(isOn: $project.sundayAssignment) {
                        Text("Sunday")
                    }
                    Toggle(isOn: $project.mondayAssignment) {
                        Text("Monday")
                    }
                    Toggle(isOn: $project.tuesdayAssignment) {
                        Text("Tuesday")
                    }
                    Toggle(isOn: $project.wednesdayAssignment) {
                        Text("Wednesday")
                    }
                    Toggle(isOn: $project.thursdayAssignment) {
                        Text("Thursday")
                    }
                    Toggle(isOn: $project.fridayAssignment) {
                        Text("Friday")
                    }
                    Toggle(isOn: $project.saturdayAssignment) {
                        Text("Saturday")
                    }
                    .onDisappear {
                        if project.mealsThisWeek && project.sundayAssignment {
                            project.mealsThisWeek = false
                        }
                        else if project.mealsThisWeek && project.mondayAssignment {
                            project.mealsThisWeek = false
                        }
                        else if project.mealsThisWeek && project.tuesdayAssignment {
                            project.mealsThisWeek = false
                        }
                        else if project.mealsThisWeek && project.wednesdayAssignment {
                            project.mealsThisWeek = false
                        }
                        else if project.mealsThisWeek && project.thursdayAssignment {
                            project.mealsThisWeek = false
                        }
                        else if project.mealsThisWeek && project.fridayAssignment {
                            project.mealsThisWeek = false
                        }
                        else if project.mealsThisWeek && project.saturdayAssignment {
                            project.mealsThisWeek = false
                        }
                    }
                }
            }

            // section 4
            Section(footer: Text("Clearing removes the recipe from the Shopping List Tab, deleting it removes the recipe entirely")) {

                Button("Clear This Week's Meals") {
                    showingClearConfirm.toggle()
                }
                .accentColor(.secondary)
            }
        }
        .navigationTitle("Edit Recipe")
        .onDisappear(perform: dataController.save)

        .alert(isPresented: $showingClearConfirm) {
            Alert(title: Text("Clear Recipe from List?"),
                  message: Text("Are you sure you want to remove this meal from this Week's Meals? This action will not remove the Recipe or ingredients entirely"),
                  primaryButton: .default(Text("Clear"),
                                          action: clear),
                  secondaryButton: .cancel())
        }
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

    func clear() {
        project.mealsThisWeek = false
        presentationMode.wrappedValue.dismiss()
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

struct EditRecipeForThisWeek_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeForThisWeek(project: Project.example)
    }
}


