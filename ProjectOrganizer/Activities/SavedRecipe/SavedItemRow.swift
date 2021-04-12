//
//  SavedItemRow.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/11/21.
//


import SwiftUI
import CoreHaptics

struct SavedItemRow: View {
    @StateObject var viewModel: ViewModel
    @ObservedObject var item: Item
    @State private var offset: CGSize = .zero
    @State private var engine = try? CHHapticEngine()



    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            ZStack(alignment: .leading) {
                Label {
                    Text(item.itemTitle)

                } icon: {
                    Image(systemName: viewModel.icon)
                        .foregroundColor(viewModel.color.map { Color($0) } ?? .clear)
                }
                .padding()
            }

        }

    }

    init(project: Project, item: Item) {
        let viewModel = ViewModel(project: project, item: item)
        _viewModel = StateObject(wrappedValue: viewModel)

        self.item = item
    }
}

struct SavedItemRow_Previews: PreviewProvider {
    static var previews: some View {
        SavedItemRow(project: Project.example, item: Item.example)
    }
}

