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
    @Binding var waveEffect: Bool
    

 //  @State private var animationComplete = false
    @State private var engine = try? CHHapticEngine()
    
    var body: some View {
        if items.isEmpty {
            Text("Add Items")
                .foregroundColor(.secondary)
                .font(.largeTitle)
        } else {
            Text(title)
                .font(.headline)
                .padding(.top)
            ForEach(items) { item in
        //        NavigationLink(destination: EditItemView(item: item)) {
                    HStack(spacing: 20) {
                        Button(action: {
                            withAnimation {
                            toggleHomeItem()
                            }

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
                         
                        })

                   


                        VStack(alignment: .leading) {
                            Text(item.itemTitle)
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
                    .background(BlurView(style: .systemUltraThinMaterialLight))
                    .cornerRadius(10)
                    .shadow(color: Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    .overlay(
                         RoundedRectangle(cornerRadius: 10)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.white, Color(item.project?.projectColor ?? "Green")]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                     )
                  
  //              }
                .animation(Animation.easeOut(duration: 0.5))

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
