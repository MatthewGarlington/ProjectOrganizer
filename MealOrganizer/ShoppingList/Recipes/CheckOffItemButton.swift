//
//  CheckOffItemButton.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/14/21.
//

import SwiftUI
import CoreHaptics

struct CheckOffItemButton: View {

    @State private var icon = "checkmark.circle.fill"
    @State private var colorStroke =  Color.green
    @State private var press = false
    var body: some View {
        CheckButton(press: $press, colorStroke: $colorStroke, icon: $icon)
    }
}

struct CheckOffItemButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckOffItemButton()
    }
}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}
struct CheckButton: View {
    @GestureState var tap = false
    @Binding var press: Bool
    @State private var animationStroke: CGFloat = 1
    @State private var explodeStroke: CGFloat = 1
    @Binding var colorStroke: Color
    @Binding var icon: String
    @State private var engine = try? CHHapticEngine()
    

    var body: some View {
        ZStack {

            Image(systemName: icon)
                .font(.system(size: 44, weight: .light))
                .foregroundColor((colorStroke))
                .opacity(press ? 1 : 0)
                .scaleEffect(press ? 1 : 0)



        }

        .frame(width: 44, height: 44)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)

                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)), radius: 3, x: -5, y: -5)

                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(press ? #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 3, x: 3, y: 3)
            }

        )
        .clipShape(Circle())
        .overlay(
            Circle()
                .trim(from: press ? 0.001 : 1, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [((colorStroke)), ((colorStroke))]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 44, height: 44)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180),
                    axis: (x: 1, y: 0, z: 0))
                .shadow(color: ((colorStroke)).opacity(0.3), radius: 5, x: 3, y: 3)
                .animation(.easeInOut)

        )



        .overlay(
            Circle()
                .stroke((colorStroke), lineWidth: 5)
                .scaleEffect(tap ? 0 : animationStroke)
                .opacity(Double(2 - animationStroke))
                .animation(
                         Animation.easeOut(duration: 1)

                     )

        )


        .overlay(
            Circle()
                .stroke((colorStroke), lineWidth: 3)
                .scaleEffect(tap ? 0 : animationStroke)
                .opacity(Double(2 - animationStroke))
                .animation(
                         Animation.easeOut(duration: 2)

                     )

        )


        .overlay(
            Circle()
                .stroke((colorStroke), lineWidth: 2)
                .scaleEffect(tap ? 0 : animationStroke)
                .opacity(Double(2 - animationStroke))
                .animation(
                         Animation.easeOut(duration: 3)

                     )

        )


        .overlay(
            Circle()
                .stroke((colorStroke), lineWidth: 1)
                .scaleEffect(tap ? 0 : explodeStroke)
                .opacity(Double(2 - explodeStroke))
                .animation(
                         Animation.easeOut(duration: 0)

                     )

        )
//
//        .shadow(color: Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
//        .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
//        .scaleEffect(tap ? 1.2 : 1)




        // Add The GestureState as follows
        .gesture(

            LongPressGesture().updating($tap) { currentState, gestureState, transaction in

                gestureState = currentState



            }
            .onEnded { value in

                self.press.toggle()

            }

        )
    }
}
