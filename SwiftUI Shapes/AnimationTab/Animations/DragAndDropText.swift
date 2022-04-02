//
//  DragAndDropText.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 02.04.2022.
//

import SwiftUI

struct DragAndDropText: View {
    @State var progress: CGFloat = 0
    @State var dragAndDropText: [DragAndDrop] = dragAndDropText_
    
    @State var dragRows: [[DragAndDrop]] = []
    @State var dropRows: [[DragAndDrop]] = []
    @State var wrongTextAnimation = false
    @State var droppedCount: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10) {
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.gray.opacity(0.25))
                    
                    Capsule()
                        .fill(Color("MainBlue"))
                        .frame(width: proxy.size.width * progress)
                }
            }
            .frame(height: 20)
            
            Text("Put the text in the correct order")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.vertical, 20)
            
            Spacer()
            DropArea(dropRows: $dropRows, dragRows: $dragRows, wrongTextAnimation: $wrongTextAnimation, progress: $progress, droppedCount: $droppedCount)
            
            Divider()
                .padding(.vertical, 20)
            
            DragArea(dragRows: dragRows)
                .padding(.bottom, 50)
            
            
        }
        .padding()
        .navigationTitle("Drag and Drop")
        .navigationBarTitleDisplayMode(.inline)
        .offset(x: wrongTextAnimation ? -30 : 0)
        .onAppear {
            if dropRows.isEmpty {
                dragAndDropText = dragAndDropText.shuffled()
                dragRows = generateGrid()
                dragAndDropText = dragAndDropText_
                dropRows = generateGrid()
            }
        }
    }
    
    func generateGrid()->[[DragAndDrop]] {
        for text in dragAndDropText.enumerated() {
            let textSize = textSize(text: text.element)
            dragAndDropText[text.offset].textSize = textSize
        }
        
        var gridArray: [[DragAndDrop]] = []
        var tempArray: [DragAndDrop] = []
        
        var currentWidth: CGFloat = 0
        // -30 is the Horizontal Padding
        let totalScreenWidth: CGFloat = UIScreen.main.bounds.width - 30
        
        for text in dragAndDropText {
            currentWidth += text.textSize
            if currentWidth < totalScreenWidth {
                tempArray.append(text)
            } else {
                gridArray.append(tempArray)
                tempArray = []
                currentWidth = text.textSize
                tempArray.append(text)
            }
        }
        
        if !tempArray.isEmpty {
            gridArray.append(tempArray)
        }
        
        return gridArray
    }
    
    func textSize(text: DragAndDrop)->CGFloat {
        let font = UIFont.systemFont(ofSize: text.fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text.value as NSString).size(withAttributes: attributes)
        
        // 15 is the HStack spacing
        return size.width + (text.padding * 2) + 15
    }
}

struct DragAndDropText_Previews: PreviewProvider {
    static var previews: some View {
        DragAndDropText()
    }
}

struct DragArea: View {
    var dragRows: [[DragAndDrop]]
    var body: some View {
        VStack(spacing: 12) {
            ForEach(dragRows, id:\.self) { row in
                HStack(spacing: 10) {
                    ForEach(row) { item in
                        Text(item.value)
                            .font(.system(size: item.fontSize))
                            .padding(.vertical, 5)
                            .padding(.horizontal, item.padding)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(.gray)
                            }
                            .onDrag {
                                return .init(contentsOf: URL(string: item.id))!
                            }
                            .opacity(item.isVisible ? 0 : 1)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(item.isVisible ? .gray.opacity(0.25) : .clear)
                            }
                    }
                }
            }
        }
    }
}

struct DropArea: View {
    @Binding var dropRows: [[DragAndDrop]]
    @Binding var dragRows: [[DragAndDrop]]
    @Binding var wrongTextAnimation: Bool
    @Binding var progress: CGFloat
    @Binding var droppedCount: CGFloat
    var body: some View {
        VStack(spacing: 12) {
            ForEach($dropRows, id:\.self) { $row in
                HStack(spacing: 10) {
                    ForEach($row) { $item in
                        Text(item.value)
                            .font(.system(size: item.fontSize))
                            .padding(.vertical, 5)
                            .padding(.horizontal, item.padding)
                            .opacity(item.isVisible ? 1 : 0)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(item.isVisible ? .clear : .gray.opacity(0.25))
                            }
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(.gray)
                                    .opacity(item.isVisible ? 1 : 0)
                            }
                            .onDrop(of: [.url], isTargeted: .constant(false)) {
                                providers in
                                
                                if let first = providers.first {
                                    let _ = first.loadObject(ofClass: URL.self) { value, error in
                                        guard let url = value else {return}
                                        if item.id == "\(url)" {
                                            withAnimation {
                                                droppedCount += 1
                                                let progress = (droppedCount / CGFloat(dragAndDropText_.count))
                                                item.isVisible = true
                                                updateArray(text: item)
                                                self.progress = progress
                                            }
                                        } else {
                                            animateWrongText()
                                        }
                                    }
                                }
                                return false
                            }
                    }
                }
            }
        }
    }
    
    func updateArray(text: DragAndDrop) {
        for index in dragRows.indices {
            for subIndex in dragRows[index].indices {
                if dragRows[index][subIndex].id == text.id {
                    dragRows[index][subIndex].isVisible = true
                }
            }
        }
    }
    
    func animateWrongText() {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)) {
            wrongTextAnimation = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)) {
                wrongTextAnimation = false
            }
        }
    }
}
