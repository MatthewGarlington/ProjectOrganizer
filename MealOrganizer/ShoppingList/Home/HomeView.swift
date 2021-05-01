//
//  HomeView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 3/18/21.
//

import SwiftUI
import CoreData

struct HomeView: View {

    static let tag: String? = "Home"
    @StateObject var viewModel: ViewModel
    @EnvironmentObject var dataController: DataController
    @Environment(\.colorScheme) var colorScheme
    @StateObject var store = UserSettings()


    



    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }

    init(dataController: DataController, tabSelection: Binding<Int>) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
        _tabSelection = tabSelection

    }

    @State var show = true
    @State var showAwardsModal = false
    @State var waveEffect = false
    @State var rotateEffect = false
    @State var backgroundColor = "Light Blue"
    @State var red = 2
    @State private var tapped = 0
    @State private var isShow = false
    @State private var isRewardsShow = false
    @State private var showDetail = false
    @State private var showAddScreen = false
    @State private var noItem = false
    @State var tap = false
    @State var press = false
    @Binding var tabSelection: Int
    let delaySeconds = 0.7
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {

                    leftCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: -150, y: -400)
                    bottomCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: -150, y: 400)
                    centerCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 0, y: 0)
                    bottomCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 200, y: -450)

                    bottomCornerCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 175, y: 390)

            }
                .frame(maxWidth: UIScreen.main.bounds.width,
                                  maxHeight: UIScreen.main.bounds.height)

                    .environmentObject(store)
                ZStack {
                smallCirclePattern()
                    .scaleEffect(tapped > 0 ? 0.90 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                    .offset(x: -50, y: -150)
                smallLightCircle()
                    .scaleEffect(tapped > 0 ? 0.90 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                    .offset(x: 100, y: 150)
                smallLightCircle()
                    .scaleEffect(tapped > 0 ? 0.90 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                    .offset(x: -125, y: -250)
                smallCirclePattern()
                    .scaleEffect(tapped > 0 ? 0.90 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                    .offset(x: 150, y: 275)

                    smallCirclePattern()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: -75, y: 100)
                    smallLightCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: -150, y: 200)
                    smallLightCircle()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 175, y: -250)
                    smallCirclePattern()
                        .scaleEffect(tapped > 0 ? 0.90 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 20).repeatCount(1, autoreverses: true), value: self.tapped)
                        .offset(x: 100, y: -150)

                }
                    .environmentObject(store)

                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Quick View")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                            // For Simulator to add Example data
                            // Replace Awards button with Add Data
                            // Button below
                            
                            //                  Button("Add Data", action: viewModel.addSampleData)
                            Button(action: {
                                withAnimation {
                                self.isRewardsShow.toggle()
                                    if isRewardsShow {
                                    self.isShow = false
                                    }
                                }
                            }, label: {

                                ZStack {
                                    Image(systemName: "rosette")
                                        .font(.title)

                                }
                            })
                            .buttonStyle(DarkButtonStyle())



                            Button(action: {
                                withAnimation {
                                self.isShow.toggle()
                                    if isShow {
                                    self.isRewardsShow = false
                                    }
                                }
                            }, label: {

                                ZStack {

                                    Image(systemName: "gear")
                                        .font(.title)
                                }
                            })
                            .buttonStyle(DarkButtonStyle())

                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading) {
                            ItemListView(title: "To Get", items: viewModel.moreToExplore, waveEffect: $waveEffect, rotateEffect: $rotateEffect, tapped: $tapped, noItem: $noItem)

                            if noItem {



                                    VStack {
                                        Button(action: {

                                            self.showAddScreen.toggle()
                                            self.tabSelection = 2 

                                        },label: {
                                            ZStack(alignment: .center) {
                                            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                                .fill(colorScheme == .dark ? Color.darkEnd : Color.offWhite)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 150)
                                                .shadow(color: colorScheme == .dark ? Color.darkStart : Color.black.opacity(0.2), radius: 10, x: colorScheme == .dark ? 5 : -5, y:  colorScheme == .dark ?  5 : -5)
                                                .shadow(color: colorScheme == .dark ? Color.darkEnd : Color.white.opacity(0.7), radius: 10, x: colorScheme == .dark ? -5 : 10, y: colorScheme == .dark ? -5 : 10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.white,
                                                                                                           Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]),
                                                                               startPoint: .leading, endPoint: .trailing),
                                                                lineWidth: 2)

                                                )

                                           Text("Add Ingredient")
                                            .padding()
                                        }
                                        })

                                    .font(.title3)
                                    .padding()

                                }
                                    .offset(y: 100)

                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                }
                if isShow {
                    ZStack {

                    Spacer()
                        .background(Color.white.opacity(0.0004))
                        .frame(maxWidth: UIScreen.main.bounds.width,
                                          maxHeight: UIScreen.main.bounds.height - 320)
                    SettingsDetailView(isShow: $isShow)
                        .environmentObject(store)

                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
                }

                if isRewardsShow {
                    ZStack {

                    Spacer()
                        .background(Color.white.opacity(0.00004))
                        .frame(maxWidth: UIScreen.main.bounds.width,
                                          maxHeight: UIScreen.main.bounds.height - 320)
                    AwardsModalView(isRewardsShow: $isRewardsShow)

                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
                }

            }
            .navigationBarHidden(true)
        }
    }
}
extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
    static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
    static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
              .background(
                  Group {
                    if configuration.isPressed {
                        Circle()
                        Circle()
                            .fill(Color.darkStart)
                            .shadow(color: Color.darkStart, radius: 10, x: 2, y: 2)
                            .shadow(color: Color.darkEnd, radius: 10, x: -10, y: -10)

                    } else {
                        Circle()
                            .fill(Color.darkEnd)
                            .shadow(color: Color.darkStart, radius: 10, x: -2, y: -2)
                            .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                    }
                  }
              )
    }
}

struct DarkBackground<S: Shape>: View {
    @Environment(\.colorScheme) var colorScheme
    var isHighlighted: Bool
    var shape: S
    @State private var tap = false

    var body: some View {
        ZStack {
            if isHighlighted {


                shape
                    
                    .fill(colorScheme == .dark ? LinearGradient(Color.darkEnd, Color.darkStart) :  LinearGradient(Color.offWhite, Color.white))
                    .shadow(color: colorScheme == .dark ? Color.darkStart : Color.black.opacity(0.2), radius: 10, x: colorScheme == .dark ? 2 : -5, y:  colorScheme == .dark ?  2 : -5)
                    .shadow(color: colorScheme == .dark ? Color.darkEnd : Color.white.opacity(0.7), radius: 10, x: colorScheme == .dark ? -2 : 10, y: colorScheme == .dark ? -2 : 10)
                    .scaleEffect(CGSize(width: 0.8, height: 0.8))
                 



            } else {
                shape
                    .fill(colorScheme == .dark ? LinearGradient(Color.darkEnd, Color.darkStart) :  LinearGradient(Color.offWhite, Color.white))
                    .shadow(color: colorScheme == .dark ? Color.darkStart :Color.black.opacity(0.2), radius: 10, x: colorScheme == .dark ? -5 : 10, y:  colorScheme == .dark ? -5 : 10)
                    .shadow(color: colorScheme == .dark ? Color.darkEnd : Color.white.opacity(0.7), radius: 10, x: colorScheme == .dark ? 5 : -5, y:  colorScheme == .dark ? 5 : -5)
                    .overlay(shape.stroke(colorScheme == .dark ? Color.darkEnd : Color.clear, lineWidth: 4))
            }
        }
    }
}

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .contentShape(Circle())
            .background(
                DarkBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataController: .preview, tabSelection: .constant(1))
    }
}

struct BlankView : View {

    var bgColor: Color

    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}



