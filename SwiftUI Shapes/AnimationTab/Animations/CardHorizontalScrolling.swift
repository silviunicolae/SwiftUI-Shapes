//
//  HorizontalCardScrolling.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 03.10.2021.
//

import SwiftUI

struct CardHorizontalScrolling: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(cardDataForHorizontalScrollingAnimation) { card in
                    GeometryReader { geometry in
                        CardViewForHorizontalScrollingAnimation(title: card.title, image: card.image, color: card.color)
                            .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 50) / -30), axis: (x: 0, y: 100.0, z: 0))
                    }
                    .frame(width: 250, height: 400)
                }
            }
            .padding([.top, .leading], 30)
            .padding(.bottom, 50)
        }.navigationTitle("Card Animation")
    }
}

struct HorizontalCardScrolling_Previews: PreviewProvider {
    static var previews: some View {
        CardHorizontalScrolling()
    }
}

struct CardViewForHorizontalScrollingAnimation: View {
    
    var title = "Stationary Bike with VR technology"
    var image = "card_Hscroll_illustration_1"
    var color = Color("SecondaryLight")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
            
            Spacer()
            
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 250, height: 200)
                .padding(.bottom, 20)
        }
        .background(color)
        .cornerRadius(20)
        .frame(width: 250, height: 400)
        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 10, y: 10)
    }
}
