//
//  UserDefaults.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/20/21.
//

import Foundation
import Combine
import SwiftUI


extension UserDefaults {
    @objc dynamic var backGroundColorCustom: String {
        get { string(forKey: "backGroundColorCustom") ?? "Green" }
        set { setValue(newValue, forKey: "backGroundColorCustom") }
    }

    @objc dynamic var accentColorCustom: String {
        get { string(forKey: "accentColorCustom") ?? "Green" }
        set { setValue(newValue, forKey: "accentColorCustom") }
    }

    @objc dynamic var foreGroundColorCustom: String {
        get { string(forKey: "foreGroundColorCustom") ?? "Green" }
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

    let colorColums = [
        GridItem(.adaptive(minimum: 44))
    ]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Background Color")) {
                    LazyVGrid(columns: colorColums) {
                            ForEach(store.colors, id: \.self, content: colorBackgroundButton)
                        }
                        .padding(.vertical)
                }
                Section(header: Text("Foreground Color")) {
                    LazyVGrid(columns: colorColums) {
                            ForEach(store.colors, id: \.self, content: colorForegroundButton)
                        }
                        .padding(.vertical)
                }
                Section(header: Text("Accent Color")) {
                    LazyVGrid(columns: colorColums) {
                            ForEach(store.colors, id: \.self, content: colorAccentButton)
                        }
                        .padding(.vertical)
                }

            }
            .navigationBarTitle("Settings")
        }
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

struct UserDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsView()
    }
}

