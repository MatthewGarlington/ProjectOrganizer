//
//  ItemListView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI
import CoreHaptics

struct ItemListView: View {
    let title: LocalizedStringKey
    let items: ArraySlice<Item>


    @EnvironmentObject var dataController: DataController
    

    @State private var completeItem = false
    @State private var engine = try? CHHapticEngine()
    
    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top)
            ForEach(items) { item in
                NavigationLink(destination: EditItemView(item: item)) {
                    HStack(spacing: 20) {
                        Button(action: {
                            toggleHomeItem()

                            func toggleHomeItem() {
                                item.completed = true

                                    if item.completed {
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
                                                duration: 0.15
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
                        }, label: {
                        Circle()
                            .stroke(Color(item.project?.projectColor ?? "Light Blue"), lineWidth: 3)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(Color(item.project?.projectColor ?? "Light Blue").opacity(completeItem ? 1 : 0.0001))
                                    .font(.system(size: 44))
                            )
                        })
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
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.white, Color(item.project?.projectColor ?? "Green")]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
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
