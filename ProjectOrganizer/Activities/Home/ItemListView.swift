//
//  ItemListView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI

struct ItemListView: View {
    let title: LocalizedStringKey
    let items: FetchedResults<Item>.SubSequence
    
    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
            ForEach(items) { item in
                NavigationLink(destination: EditItemView(item: item)) {
                    HStack(spacing: 20) {
                        Circle()
                            .stroke(Color(item.project?.projectColor ?? "Light Blue"), lineWidth: 3)
                            .frame(width: 44, height: 44)
                        VStack(alignment: .leading) {
                            Text(item.itemTitle)
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if item.itemDetail.isEmpty == false {
                                Text(item.itemDetail)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(BlurView(style: .systemUltraThinMaterialLight))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                    .overlay(
                         RoundedRectangle(cornerRadius: 10)
                             .stroke(LinearGradient(gradient: Gradient(colors: [Color.white, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                     )
                }
            }
        }
    }
}

//struct ItemListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemListView()
//    }
//}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}
