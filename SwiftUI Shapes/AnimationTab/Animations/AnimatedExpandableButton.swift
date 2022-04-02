//
//  AnimatedExpandableButton.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 09.11.2021.
//

import SwiftUI

struct ExpandableButtonItem: Identifiable {
    let id = UUID()
    let image: String
    let label: String
    private(set) var action: (() -> Void)? = nil
}

struct AnimatedExpandableButton: View {
    @State var text = "none"
    var body: some View {
        VStack {
            //your content here
            Spacer()
            Text("\(self.text) pressed")
                .font(.title2)
            HStack {
                Spacer()
                
                ExpandableButtonView(
                    primaryItem: ExpandableButtonItem(image: "plus", label:""),
                    secondaryItems: [
                        ExpandableButtonItem(image: "lock.rotation.open", label: "Lock") {
                            withAnimation() { self.text = "Lock" }
                        },
                        ExpandableButtonItem(image: "xmark.bin", label: "Delete") {
                            withAnimation() { self.text = "Delete" }
                        },
                        ExpandableButtonItem(image: "archivebox", label: "Archive") {
                            withAnimation() { self.text = "Archive" }
                        } ] )
            }
            .padding(.trailing, 30)
            .padding(.bottom, 80)
        }
    }
}

struct AnimatedExpandableButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedExpandableButton()
    }
}

struct ExpandableButtonView: View {
    let primaryItem: ExpandableButtonItem
    let secondaryItems: [ExpandableButtonItem]
    let none: () -> Void = {}
    let size: CGFloat = 70
    var cornerRadius: CGFloat = 35
    @State var isExpanded = false
    
    var body: some View {
        VStack {
            if isExpanded {
                ForEach(secondaryItems) { item in
                    Button(action: item.action ?? self.none)
                    {
                        HStack {
                            Image(systemName: item.image)
                            Text(item.label)
                        }
                        .font(.body)
                        .foregroundColor(.white)
                    }}
                .padding()
            }
            Button(action: {
                withAnimation {
                    self.isExpanded.toggle()
                }
                self.primaryItem.action?()
            }) {
                Image(systemName: primaryItem.image)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .rotationEffect(self.isExpanded ? .degrees(45) : .degrees(0))
            }
            .frame(width: size, height: size)
        }
        .background(Color("MainBlue"))
        .cornerRadius(cornerRadius)
        .shadow(color: Color.black.opacity(0.17), radius: 3, x:2, y: 2)
    }
}
