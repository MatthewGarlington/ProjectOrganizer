//
//  Button-Extension.swift
//  MealOrganizer
//
//  Created by Matthew Garlington on 5/1/21.
//

import SwiftUI

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
