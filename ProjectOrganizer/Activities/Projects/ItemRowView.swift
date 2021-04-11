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
    
  
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            ZStack(alignment: .leading) {
                Label {
                    Text(item.itemTitle)
                    
                } icon: {
                    Image(systemName: viewModel.icon)
                        .foregroundColor(viewModel.color.map { Color($0) } ?? .clear)

                        .onTapGesture {
                            toggleHomeItem()

                            func toggleHomeItem() {
                                item.completed.toggle()


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

                                    } else {
                                        item.completed = false

                                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                             impactMed.impactOccurred()
                                    }
                            }
                        }

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

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example, item: Item.example)
    }
}
