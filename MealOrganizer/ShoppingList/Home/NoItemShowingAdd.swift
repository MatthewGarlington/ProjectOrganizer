//
//  NoItemShowingAdd.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/24/21.
//

import SwiftUI

struct NoItemShowingAdd: View {
    @Binding var showAddScreen: Bool
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color.black.opacity(0.4))
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .overlay(
                   Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.white,
                                                                           Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]),
                                               startPoint: .leading, endPoint: .trailing),
                                lineWidth: 2)
                )
            VStack {
                Button(action: {

                    self.showAddScreen.toggle()

                },label: {
                   Text("Add Recipe")
                    .padding()
                })


            }

            .foregroundColor(.white)
            .font(.title3)
            .padding()

        }
    }
}

struct NoItemShowingAdd_Previews: PreviewProvider {
    static var previews: some View {
        NoItemShowingAdd(showAddScreen: .constant(false))
    }
}
