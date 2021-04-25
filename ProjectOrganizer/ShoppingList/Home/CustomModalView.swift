//
//  CustomModalView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/22/21.
//

import Foundation
import Combine
import SwiftUI

enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    var isDragging: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }

}

struct SettingsDetailView: View {

    enum ViewState {
        case full
        case half
    }

    @GestureState private var dragState = DragState.inactive
    @State private var positionOffset: CGFloat = 0.0
    @State private var viewState = ViewState.half
    @State private var scrollOffset: CGFloat = 0.0
    @StateObject var store = UserSettings()
    @Binding var isShow: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                HandleBar()
                TitleBar()
                    .frame(height: 20)
                    .padding(.horizontal)


                ScrollView(.vertical) {

                    GeometryReader { scrollViewProxy in
                        Color.clear.preference(key: ScrollOffsetKey.self, value: scrollViewProxy.frame(in: .named("scrollview")).minY)
                    }
                    .frame(height: 0)

                    VStack {

                        UserDefaultsView()
                            .environmentObject(store)
                    }
                    .padding(.bottom)
                    .animation(nil)
                }
            }
            .background(BlurView(style: .systemUltraThinMaterial))
            .cornerRadius(10, antialiased: true)
            .coordinateSpace(name: "scrollview")
            .offset(y: geometry.size.height/1.80 + self.dragState.translation.height + self.positionOffset)
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
                                    self.positionOffset = -geometry.size.height/1.80 + 50
                                    self.viewState = .full
                                }

                                // Threshold #2
                                // Slide down and when it goes pass the threshold
                                // dismiss the view by setting isShow to false
                                if value.translation.height > geometry.size.height * 0.3 {
                                    self.isShow = false
                                }
                            }

                        })
            )
        }
    }
}

struct SettingsDetailView_Previews: PreviewProvider {
    @StateObject var store = UserSettings()
    static var previews: some View {
        SettingsDetailView(isShow: .constant(true))
            .background(Color.black.opacity(0.3))
            .edgesIgnoringSafeArea(.all)



    }
}

struct HandleBar: View {

    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundColor(Color(.systemGray5))
            .cornerRadius(10)
    }
}

struct TitleBar: View {

    var body: some View {
        HStack {
            Text("Settings")
                .bold()
                .font(.largeTitle)


            Spacer()
        }
        .padding([.horizontal, .top])
    }
}

struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat

    static var defaultValue = CGFloat.zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}




extension UserDefaults {
    @objc dynamic var backGroundColorCustom: String {
        get { string(forKey: "backGroundColorCustom") ?? "Dark Blue" }
        set { setValue(newValue, forKey: "backGroundColorCustom") }
    }

    @objc dynamic var accentColorCustom: String {
        get { string(forKey: "accentColorCustom") ?? "Dark Blue" }
        set { setValue(newValue, forKey: "accentColorCustom") }
    }

    @objc dynamic var foreGroundColorCustom: String {
        get { string(forKey: "foreGroundColorCustom") ?? "Dark Blue" }
        set { setValue(newValue, forKey: "foreGroundColorCustom") }
    }
}



class UserSettings: ObservableObject {

    @Published var backGroundColorCustom: String = UserDefaults.standard.backGroundColorCustom {
        didSet {
            UserDefaults.standard.backGroundColorCustom = backGroundColorCustom
        }
    }


    @Published var accentColorCustom: String = UserDefaults.standard.accentColorCustom {
        didSet {
            UserDefaults.standard.accentColorCustom = accentColorCustom
        }
    }

    @Published var foreGroundColorCustom: String = UserDefaults.standard.foreGroundColorCustom {
        didSet {
            UserDefaults.standard.foreGroundColorCustom = foreGroundColorCustom
        }
    }

    public var colors = ["Pink",
                         "Purple",
                         "Orange",
                         "Gold",
                         "Green",
                         "Teal",
                         "Light Blue",
                         "Dark Blue",
                         "Midnight",
                         "Dark Gray",
                         "Gray"]

    private var backGroundCancel: AnyCancellable?
    private var accentColorCancel: AnyCancellable?
    private var foregroundColorCancel: AnyCancellable?

    init() {

        backGroundCancel = UserDefaults.standard.publisher(for: \.backGroundColorCustom)
            .sink(receiveValue: { [weak self] newValue in
                guard let self = self else { return }
                if newValue != self.backGroundColorCustom { // avoid cycling !!
                    self.backGroundColorCustom = newValue
                }
            })

        accentColorCancel = UserDefaults.standard.publisher(for: \.accentColorCustom)
            .sink(receiveValue: { [weak self] newValue in
                guard let self = self else { return }
                if newValue != self.accentColorCustom { // avoid cycling !!
                    self.accentColorCustom = newValue
                }
            })

        foregroundColorCancel = UserDefaults.standard.publisher(for: \.foreGroundColorCustom)
            .sink(receiveValue: { [weak self] newValue in
                guard let self = self else { return }
                if newValue != self.foreGroundColorCustom { // avoid cycling !!
                    self.foreGroundColorCustom = newValue
                }
            })
    }
}

struct UserDefaultsView: View {

    @EnvironmentObject var store: UserSettings

    let rows = [GridItem(.fixed(40), spacing: 20),
                GridItem(.fixed(40), spacing: 20)]

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 35) {
                VStack {
                    Section(header: Text("Background Color").bold()) {
                        LazyHGrid(rows: rows) {
                            ForEach(store.colors, id: \.self, content: colorBackgroundButton)
                        }

                        .padding(.vertical)
                    }

                }
                .padding()
                .background(Color("BackGround2").opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))

                Divider()

                VStack {
                    Section(header: Text("Foreground Color").bold()) {
                        LazyHGrid(rows: rows) {
                            ForEach(store.colors, id: \.self, content: colorForegroundButton)
                        }
                        .padding(.vertical)
                    }
                }
                .padding()
                .background(Color("BackGround2").opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                Divider()
                VStack {
                    Section(header: Text("Accent Color").bold()) {
                        LazyHGrid(rows: rows) {
                            ForEach(store.colors, id: \.self, content: colorAccentButton)
                        }
                        .padding(.vertical)
                    }
                }
                .padding()
                .background(Color("BackGround2").opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            }
        }
        .padding()


    }
    func colorBackgroundButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6)
            if item == store.backGroundColorCustom {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            store.backGroundColorCustom  = item
        }
    }

    func colorForegroundButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6)
            if item == store.foreGroundColorCustom {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            store.foreGroundColorCustom  = item
        }
    }

    func colorAccentButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6)
            if item == store.accentColorCustom {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            store.accentColorCustom  = item
        }
    }
}



