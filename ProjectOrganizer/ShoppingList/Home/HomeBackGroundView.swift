//
//  HomeBackGroundView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/13/21.
//

import SwiftUI

struct HomeBackGroundView: View {

    @StateObject var store = UserSettings()


    

    var body: some View {

            ZStack {

                leftCornerCircle()
                    .offset(x: -150, y: -400)
                bottomCornerCircle()
                    .offset(x: -150, y: 400)
                centerCornerCircle()
                    .offset(x: 0, y: 0)
                bottomCornerCircle()
                    .offset(x: 200, y: -450)

                bottomCornerCircle()
                    .offset(x: 175, y: 390)

        }
    }
}


struct HomeForegroundView: View {
    @StateObject var store = UserSettings()
    var body: some View {
    ZStack {
    smallCirclePattern()
        .offset(x: -50, y: -150)
    smallLightCircle()
        .offset(x: 100, y: 150)
    smallLightCircle()
        .offset(x: -125, y: -250)
    smallCirclePattern()
        .offset(x: 150, y: 275)

        smallCirclePattern()
            .offset(x: -75, y: 100)
        smallLightCircle()
            .offset(x: -150, y: 200)
        smallLightCircle()
            .offset(x: 175, y: -250)
        smallCirclePattern()
            .offset(x: 100, y: -150)

    }
    }

}


struct HomeForegroundView_Previews: PreviewProvider {
    static var previews: some View {
        HomeForegroundView()
    }
}

struct leftCornerCircle: View {

    @StateObject var store = UserSettings()

    var body: some View {

        ZStack(alignment: .center){

            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(store.backGroundColorCustom))

            Circle()
                .frame(width: 80, height: 80)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.6))
                .animation(.spring())
            Circle()
                .frame(width: 120, height: 120)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.5))
                .animation(.spring())

            Circle()
                .frame(width: 160, height: 160)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.4))
                .animation(.spring())
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.3))
                .animation(.spring())
            Circle()
                .frame(width: 240, height: 240)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.2))
                .animation(.spring())

            Circle()
                .frame(width: 280, height: 280)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.1))
                .animation(.spring())
        }
    }
}


struct smallLightCircle: View {
    @StateObject var store = UserSettings()
    var body: some View {
        ZStack(alignment: .center){

            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(store.foreGroundColorCustom))
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color(store.foreGroundColorCustom).opacity(0.6))
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(Color(store.foreGroundColorCustom).opacity(0.5))

            Circle()
                .frame(width: 70, height: 70)
                .foregroundColor(Color(store.foreGroundColorCustom).opacity(0.4))
            Circle()
                .frame(width: 80, height: 80)
                .foregroundColor(Color(store.foreGroundColorCustom).opacity(0.3))
            Circle()
                .frame(width: 90, height: 90)
                .foregroundColor(Color(store.foreGroundColorCustom).opacity(0.2))

            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(store.foreGroundColorCustom).opacity(0.1))
        }
        .environmentObject(store)
    }

}

struct bottomCornerCircle: View {
    @StateObject var store = UserSettings()

    var body: some View {
        ZStack(alignment: .center){

            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(store.backGroundColorCustom))
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.6))
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.5))

            Circle()
                .frame(width: 250, height: 250)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.4))
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.3))
            Circle()
                .frame(width: 350, height: 350)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.2))

            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.1))

            Circle()
                .frame(width: 450, height: 450)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.1))

        }
        .environmentObject(store)
    }


}

struct centerCornerCircle: View {
    @StateObject var store = UserSettings()
    var body: some View {
        ZStack(alignment: .center){

            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(store.backGroundColorCustom))
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.6))
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.5))

            Circle()
                .frame(width: 250, height: 250)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.4))
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.3))
            Circle()
                .frame(width: 350, height: 350)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.2))

            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(Color(store.backGroundColorCustom).opacity(0.1))
        }
        .environmentObject(store)
    }


}


struct smallCirclePattern: View {
    @StateObject var store = UserSettings()
    var body: some View {
        ZStack(alignment: .center){

            Spacer()
                .frame(width: 20, height: 20)
                .background(Color(store.foreGroundColorCustom))
                .clipShape(Circle())
            Spacer()
                .frame(width: 30, height: 30)
                .background(Color(store.foreGroundColorCustom).opacity(0.6))
                .clipShape(Circle())
            Spacer()
                .frame(width: 40, height: 40)
                .background(Color(store.foreGroundColorCustom).opacity(0.5))
                .clipShape(Circle())

            Spacer()
                .frame(width: 50, height: 50)
                .background(Color(store.foreGroundColorCustom).opacity(0.4))
                .clipShape(Circle())
            Spacer()
                .frame(width: 60, height: 60)
                .background(Color(store.foreGroundColorCustom).opacity(0.3))
                .clipShape(Circle())
            Spacer()
                .frame(width: 70, height: 70)
                .background(Color(store.foreGroundColorCustom).opacity(0.2))
                .clipShape(Circle())

            Spacer()
                .frame(width: 70, height: 70)
                .background(Color(store.foreGroundColorCustom).opacity(0.1))
                .clipShape(Circle())
        }
        .environmentObject(store)
    }
}





