//
//  AwardsModalView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/23/21.
//

import Foundation
import Combine
import SwiftUI

struct AwardsModalView: View {
    enum ViewState {
        case full
        case half
    }

    @GestureState private var dragState = DragState.inactive
    @State private var positionOffset: CGFloat = 0.0
    @State private var viewState = ViewState.half
    @State private var scrollOffset: CGFloat = 0.0
    @StateObject var store = UserSettings()
    @Binding var isRewardsShow: Bool

    @EnvironmentObject var dataController: DataController
    @State private var selectedAward = Award.example
    @State private var showingAwardDetail = false
    var colums: [GridItem] {
        [GridItem(.fixed(40), spacing: 40),
                    GridItem(.fixed(40), spacing: 40),
                    GridItem(.fixed(40), spacing: 40)]
    }

    var body: some View {

        GeometryReader { geometry in
            VStack {
                Spacer()

                HandleBar()
                TitleBarTwo()
                    .frame(height: 20)
                    .padding(.horizontal)


                ScrollView(.vertical) {

                    GeometryReader { scrollViewProxy in
                        Color.clear.preference(key: ScrollOffsetKey.self, value: scrollViewProxy.frame(in: .named("scrollview")).minY)
                    }
                    .frame(height: 0)

                        ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: colums) {
                            ForEach(Award.allAwards) { award in
                                Button {
                                    selectedAward = award
                                    showingAwardDetail = true
                                } label: {
                                    Image(systemName: award.image)
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(color(for: award))
                                }
                            }
                    }
                        .padding()

                    }
                    .padding(.bottom)
                    .animation(nil)
                }
            }
            .background(BlurView(style: .systemUltraThinMaterial))
            .cornerRadius(10, antialiased: true)
           // .disabled(self.viewState == .half)
            .coordinateSpace(name: "scrollview")
            .offset(y: geometry.size.height/1.8 + self.dragState.translation.height + self.positionOffset)
            .offset(y: self.scrollOffset)
            .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            .edgesIgnoringSafeArea(.all)
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                if self.viewState == .full {
                    self.scrollOffset = value > 0 ? value : 0

                    if self.scrollOffset > 120 {
                        self.positionOffset = 0
                        self.viewState = .half
                        self.scrollOffset = 0
                    }
                }
            }
            .gesture(DragGesture()
                .updating(self.$dragState, body: { (value, state, transaction) in
                    state = .dragging(translation: value.translation)
                    })
                .onEnded({ (value) in

                    if self.viewState == .half {
                        // Threshold #1
                        // Slide up and when it goes beyond the threshold
                        // change the view state to fully opened by updating
                        // the position offset
                        if value.translation.height < -geometry.size.height * 0.25 {
                            self.positionOffset = -geometry.size.height/1.8 + 50
                            self.viewState = .full
                        }

                        // Threshold #2
                        // Slide down and when it goes pass the threshold
                        // dismiss the view by setting isShow to false
                        if value.translation.height > geometry.size.height * 0.3 {
                            self.isRewardsShow = false
                        }
                    }

                })
            )
        }

        .alert(isPresented: $showingAwardDetail, content: getAwardAlert)
    }

    func color(for award: Award) -> Color {
        dataController.hasEarned(award: award) ? Color(award.color) : Color.secondary.opacity(0.5)

    }

    func getAwardAlert() -> Alert {

        if dataController.hasEarned(award: selectedAward) {
            return Alert(title: Text("Unlocked \(selectedAward.name)"),
                         message: Text("\(selectedAward.description)"),
                         dismissButton: .default(Text("Ok")))
        } else {
            return Alert(title: Text("Locked"), message: Text(selectedAward.description),
                         dismissButton: .default(Text("Ok")))
        }
    }
    }


struct AwardsModalView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsModalView(isRewardsShow: .constant(false))
    }
}
