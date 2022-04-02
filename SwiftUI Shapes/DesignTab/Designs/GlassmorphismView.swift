//
//  GlassmorphismView.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 28.09.2021.
//

import SwiftUI

struct GlassmorphismView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("MainBlue"), Color("Secondary") ,Color("SecondaryLight")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.bottom)
            
            Circle()
                .frame(width: 100)
                .foregroundColor(.white)
                .opacity(0.4)
                .offset(x: -UIScreen.main.bounds.size.width/2 + 20, y: -170)
                .blur(radius: 4)
            
            GlassWindow()
            
            Circle()
                .frame(width: 150)
                .foregroundColor(.white)
                .opacity(0.35)
                .offset(x: UIScreen.main.bounds.size.width/2 - 40, y: 170)
                .blur(radius: 6)
        }
        .navigationTitle("Glassmorphism")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GlassmorphismView_Previews: PreviewProvider {
    static var previews: some View {
        GlassmorphismView()
    }
}

struct GlassWindow: View {
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white).opacity(0.2)
                .frame(width: UIScreen.main.bounds.size.width-30, height: 350)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 10)
                .blur(radius: 1)
            
            GlassWindowText()
        }
    }
}

struct GlassWindowText: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("SwiftUI Shapes")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Glassmorphism")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Build cool designs using SwiftUI")
                    .multilineTextAlignment(.leading)
                    .padding(.top, 5)
            }.padding(.trailing, 10)
            Image("glassmorphism_img_1")
                .resizable()
                .scaledToFit()
                .frame(height: 100, alignment: .center)
        }
        .frame(width: UIScreen.main.bounds.size.width-100, height: 250)
    }
}
