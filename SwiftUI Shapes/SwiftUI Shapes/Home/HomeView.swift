//
//  HomeView.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 26.08.2021.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
            List {
                ForEach(homeAnimations) { animation in
                    NavigationLink(destination: animation.viewName) {
                        Text(animation.name)
                    }
                }
            }.padding(.top, 10)
        .navigationTitle("SwiftUI Shapes")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
