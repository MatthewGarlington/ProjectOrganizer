//
//  PurchasedListView.swift
//  MealOrganizer
//
//  Created by Matthew Garlington on 5/1/21.
//

import SwiftUI
import CoreHaptics

struct PurchasedListView: View {
    let title: LocalizedStringKey
    let items: ArraySlice<Item>

    @EnvironmentObject var dataController: DataController
    @Binding var waveEffect: Bool
    @Binding var rotateEffect: Bool
    @Binding var tapped: Int
    let delaySeconds = 0.7
    @Binding var noItem: Bool



    @State private var engine = try? CHHapticEngine()

    var body: some View {

        if items.isEmpty {

            VStack(spacing: 50) {
                Spacer()
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(Color.black.opacity(0.4))
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                .stroke(LinearGradient(gradient: Gradient(colors: [Color.white,
                                                                                   Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]),
                                                       startPoint: .leading, endPoint: .trailing),
                                        lineWidth: 2)
                        )
                    VStack {
                        Text("Nothing to show right now")
                        Text("Complete Items on the Shopping List!")
                    }
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
                }
            }
        } else {
            Spacer()

            ForEach(items) { item in

                HStack(spacing: 20) {

                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            Text(item.itemTitle)

                            if item.itemAmount.isEmpty == false {
                                Text("(\(item.itemAmount))")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onLongPressGesture {
                            withAnimation {
                                self.waveEffect.toggle()
                            }
                        }

                        if item.itemDetail.isEmpty == false {
                            Text(item.itemDetail)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(BlurView(style: .systemThinMaterial))
                .cornerRadius(10)
                .shadow(color: Color(item.project?.color ?? "Green").opacity(0.3), radius: 10, x: 5, y: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.white, Color(item.project?.projectColor ?? "Green")]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                )
                .animation(Animation.easeOut(duration: 0.5))

            }
        }
    }
}
