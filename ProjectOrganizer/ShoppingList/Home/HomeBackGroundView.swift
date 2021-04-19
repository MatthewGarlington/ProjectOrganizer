//
//  HomeBackGroundView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/13/21.
//

import SwiftUI

struct HomeBackGroundView: View {
    @State private var show = false
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
                smallCirclePattern()
                    .offset(x: 0, y: -150)
                    .rotationEffect(Angle(degrees:  show ? 360 : 0))
                    // Animation Rotates
                    .animation(Animation.linear(duration: 80).repeatForever(autoreverses: false))
                    // Triggers the the show varible upon the blob appearing
                    .onAppear { self.show = true }
                smallLightCircle()
                    .offset(x: 100, y: 150)
                    .rotationEffect(Angle(degrees:  show ? 360 : 0))
                    // Animation Rotates
                    .animation(Animation.linear(duration: 80).repeatForever(autoreverses: false))
                    // Triggers the the show varible upon the blob appearing
                    .onAppear { self.show = true }
                smallLightCircle()
                    .offset(x: 0, y: -250)
                    .rotationEffect(Angle(degrees:  show ? 360 : 0))
                    // Animation Rotates
                    .animation(Animation.linear(duration: 80).repeatForever(autoreverses: false))
                    // Triggers the the show varible upon the blob appearing
                    .onAppear { self.show = true }
                smallCirclePattern()
                    .offset(x: 100, y: 300)
                    .rotationEffect(Angle(degrees:  show ? 360 : 0))
                    // Animation Rotates
                    .animation(Animation.linear(duration: 80).repeatForever(autoreverses: false))
                    // Triggers the the show varible upon the blob appearing
                    .onAppear { self.show = true }
        }



    }
}


struct HomeBackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBackGroundView()
    }
}

struct leftCornerCircle: View {
    var body: some View {
        ZStack(alignment: .center){

            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))

            Circle()
                .frame(width: 80, height: 80)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.6))
            Circle()
                .frame(width: 120, height: 120)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.5))

            Circle()
                .frame(width: 160, height: 160)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.4))
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.3))
            Circle()
                .frame(width: 240, height: 240)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.2))

            Circle()
                .frame(width: 280, height: 280)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.1))
        }
    }

}


struct smallLightCircle: View {
    var body: some View {
        ZStack(alignment: .center){

            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.6))
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.5))

            Circle()
                .frame(width: 70, height: 70)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.4))
            Circle()
                .frame(width: 80, height: 80)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.3))
            Circle()
                .frame(width: 90, height: 90)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.2))

            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).opacity(0.1))
        }
    }
}

struct bottomCornerCircle: View {
    var body: some View {
        ZStack(alignment: .center){

            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)).opacity(0.6))
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)).opacity(0.5))

            Circle()
                .frame(width: 250, height: 250)
                .foregroundColor(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)).opacity(0.4))
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)).opacity(0.3))
            Circle()
                .frame(width: 350, height: 350)
                .foregroundColor(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)).opacity(0.2))

            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.1))

            Circle()
                .frame(width: 450, height: 450)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.1))

        }
    }
}

struct centerCornerCircle: View {
    var body: some View {
        ZStack(alignment: .center){

            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.6))
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.5))

            Circle()
                .frame(width: 250, height: 250)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.4))
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.3))
            Circle()
                .frame(width: 350, height: 350)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.2))

            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.1))
        }
    }
}


struct smallCirclePattern: View {
    var body: some View {
        ZStack(alignment: .center){

            Spacer()
                .frame(width: 20, height: 20)
                .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                .clipShape(Circle())
            Spacer()
                .frame(width: 30, height: 30)
                .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.6))
                .clipShape(Circle())
            Spacer()
                .frame(width: 40, height: 40)
                .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.5))
                .clipShape(Circle())

            Spacer()
                .frame(width: 50, height: 50)
                .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.4))
                .clipShape(Circle())
            Spacer()
                .frame(width: 60, height: 60)
                .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.3))
                .clipShape(Circle())
            Spacer()
                .frame(width: 70, height: 70)
                .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.2))
                .clipShape(Circle())

            Spacer()
                .frame(width: 70, height: 70)
                .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).opacity(0.1))
                .clipShape(Circle())
        }
    }
}



