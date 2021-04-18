//
//  ItemRowView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI
import CoreHaptics

struct ItemRowView: View {
    @StateObject var viewModel: ViewModel
    @ObservedObject var item: Item
    @State private var offset: CGSize = .zero
    @State private var engine = try? CHHapticEngine()
    @State private var icon = "checkmark.circle.fill"
    @State private var colorStroke = Color.green
    @State private var press = false
    @State private var animationStroke: CGFloat = 1
    @State private var explodeStroke: CGFloat = 1
    @GestureState var tap = false
    
  
    
    var body: some View {
        let colorItem = viewModel.color.map { Color($0) } ?? .clear

        NavigationLink(destination: EditItemView(item: item)) {
            ZStack(alignment: .center) {
                Label {
                    HStack {
                        
                        Text(item.itemTitle)
                        Text("(\(item.itemAmount))")


                    }
                    .foregroundColor(colorItem)
                    .padding()
                } icon: {
                    Image(systemName: viewModel.icon)
                        .foregroundColor(colorItem)
                        .font(.system(size: 20))
                        .frame(width: 50, height: 50)

                        .background(
                            ZStack {
                                Circle()
                                    .foregroundColor(.clear)
                                    .background(BlurView(style: item.completed ? UIBlurEffect.Style.systemThickMaterial :UIBlurEffect.Style.systemUltraThinMaterial ))

                            }

                        )
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .trim(from: press ? 0.001 : 1, to: 1)
                                .stroke(LinearGradient(gradient: Gradient(colors: [((colorItem)), ((colorItem))]), startPoint: .topLeading, endPoint: .topTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                .frame(width: 50, height: 50)
                                .rotationEffect(Angle(degrees: 90))
                                .rotation3DEffect(Angle(degrees: 180),
                                    axis: (x: 1, y: 0, z: 0))
                               // .shadow(color: ((colorStroke)).opacity(0.3), radius: 5, x: 3, y: 3)
                                .animation(.easeInOut)

                        )



                        .overlay(
                            Circle()
                                .stroke((colorItem), lineWidth: 5)
                                .scaleEffect(tap ? 0 : animationStroke)
                                .opacity(Double(2 - animationStroke))
                                .animation(
                                         Animation.easeOut(duration: 1)

                                     )

                        )
                //        .onTapGesture {
                //
                //            self.animationStroke = 2
                //        }

                        .overlay(
                            Circle()
                                .stroke((colorItem), lineWidth: 3)
                                .scaleEffect(tap ? 0 : animationStroke)
                                .opacity(Double(2 - animationStroke))
                                .animation(
                                         Animation.easeOut(duration: 2)

                                     )

                        )


                        .overlay(
                            Circle()
                                .stroke((colorItem), lineWidth: 2)
                                .scaleEffect(tap ? 0 : animationStroke)
                                .opacity(Double(2 - animationStroke))
                                .animation(
                                         Animation.easeOut(duration: 3)

                                     )

                        )


                        .overlay(
                            Circle()
                                .stroke((colorItem), lineWidth: 1)
                                .scaleEffect(tap ? 0 : explodeStroke)
                                .opacity(Double(2 - explodeStroke))
                                .animation(
                                         Animation.easeOut(duration: 0)

                                     )

                        )

                }



                .padding()
            }

            .gesture(
                LongPressGesture().updating($tap) { currentState, gestureState, transaction in
                    gestureState = currentState


                    item.completed.toggle()

                    if item.completed {
                           // Trigger Custom Haptics
                        self.press = true
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

                        } else {
                            item.completed = false
                            self.press = false 

                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                 impactMed.impactOccurred()
                        }

                }
            )


            .onTapGesture(count: 1) {


               // self.press = true
                item.completed.toggle()


                    if item.completed {
                           // Trigger Custom Haptics
                        self.press = true
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

                        } else {
                            item.completed = false
                            self.press = false 

                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                 impactMed.impactOccurred()
                        }

                }



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

