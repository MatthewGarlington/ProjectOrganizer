//
//  ItemRowView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

struct ItemRowView: View {
    @StateObject var viewModel: ViewModel
    @ObservedObject var item: Item
    @State private var offset: CGSize = .zero
  
    
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
        .onLongPressGesture {
            item.completed.toggle()
        }
    }
    
    init(project: Project, item: Item) {
        let viewModel = ViewModel(project: project, item: item)
        _viewModel = StateObject(wrappedValue: viewModel)
        
        self.item = item
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example, item: Item.example)
    }
}
