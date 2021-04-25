//
//  EditItemView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//


import SwiftUI

struct EditItemView: View {
    let item: Item
    @EnvironmentObject var dataController: DataController
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    @State private var amount: String

    init(item: Item) {
        self.item = item
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
        _amount = State(wrappedValue: item.amount ?? "")
    }
    var body: some View {
        Form {
            Section(header: Text("Basic Settings")) {
                // The onChange modifier adds a call to the create extension of Binding-onChange which stores the data
                
                TextField("Ingredient name", text: $title.onChange(update))
                TextField("Description", text: $detail.onChange(update))
                TextField("Amount", text: $amount.onChange(update))
                
            }
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                
            }
            Section {
                Toggle("Mark Completed", isOn: $completed.onChange(update))
                
            }
            
            
        }
        .navigationTitle("Edit Ingredient")
       
        // Call save to Core Data when view goes away
        .onDisappear(perform: dataController.save)
    }
    func update() {
        // Notify any view that has this item that it is about to change
        item.project?.objectWillChange.send()
        item.title = title
        item.detail = detail
        item.priority = Int16(priority)
        item.completed = completed
        item.amount = amount
    }
}
 
struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
            .environmentObject(DataController())
    }
}
