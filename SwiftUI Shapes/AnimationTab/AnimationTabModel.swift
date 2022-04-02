//
//  AnimationTabModel.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 03.10.2021.
//

import SwiftUI

// MARK: - Horizontal Scrolling Animation
struct CardForHorizontalScrollingAnimation: Identifiable {
    
    var id    = UUID()
    var title : String
    var image : String
    var color : Color
}

let cardDataForHorizontalScrollingAnimation = [
    CardForHorizontalScrollingAnimation(title: "Stationary Bike with VR technology",
         image: "card_Hscroll_illustration_1",
         color: Color("SecondaryLight")),
    CardForHorizontalScrollingAnimation(title: "Treadmill with VR technology",
         image: "card_Hscroll_illustration_2",
         color: Color("LightBlue")),
    CardForHorizontalScrollingAnimation(title: "Indoor yoga",
         image: "card_Hscroll_illustration_3",
         color: Color("Secondary")),
    CardForHorizontalScrollingAnimation(title: "Exercise with weights",
         image: "card_Hscroll_illustration_4",
         color: Color("MainBlue")),
]


// MARK: - Drag and Drop Text
struct DragAndDrop: Identifiable, Hashable, Equatable {
    var id = UUID().uuidString
    var value : String
    var padding: CGFloat = 10
    var textSize: CGFloat = 0
    var fontSize: CGFloat = 19
    var isVisible: Bool = false
}

var dragAndDropText_ = [
    DragAndDrop(value: "SwiftUI"),
    DragAndDrop(value: "Shapes"),
    DragAndDrop(value: "."),
    DragAndDrop(value: "Build"),
    DragAndDrop(value: "cool"),
    DragAndDrop(value: "designs"),
    DragAndDrop(value: "using"),
    DragAndDrop(value: "SwiftUI")
]
