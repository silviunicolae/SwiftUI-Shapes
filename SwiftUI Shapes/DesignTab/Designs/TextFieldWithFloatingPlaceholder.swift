//
//  TextFieldWithFloatingPlaceholder.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 09.11.2021.
//

import SwiftUI

struct TextFieldWithFloatingPlaceholder: View {
    @State var user = ""
    @State var email = ""
    var body: some View {
        VStack(spacing: 20) {
            FloatingTextField(placeholder: "Username", text: $user)
            FloatingTextField(placeholder: "Email", text: $email)
                .keyboardType(.emailAddress)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color("SecondaryLight"))
    }
}

struct TextFieldWithFloatingPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithFloatingPlaceholder()
        Group {
            FloatingTextField(placeholder: "Placeholder 1", text: .constant(""))
            FloatingTextField(placeholder: "Placeholder 1", text: .constant("Text 1"))
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

struct FloatingTextField: View {
    var placeholder: String
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeholder)
                .textFiledPlaceholder(text: self.text)
            TextField("", text: $text)
        }
        .textFieldShape(text: self.text)
    }
}

extension View {
    func textFieldShape(text: String) -> some View {
        self.animation(.easeOut, value: text.isEmpty)
            .foregroundColor(.black)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .frame(width: UIScreen.main.bounds.width - 60, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(text.isEmpty ? .gray.opacity(0.5) : .gray.opacity(0.9), lineWidth: 0.5)
                    .background(.white)
                    .cornerRadius(8)
            )
    }
    
    func textFiledPlaceholder(text: String) -> some View {
        self.font(text.isEmpty ? .body : .subheadline)
            .foregroundColor(.gray)
            .padding(.horizontal, text.isEmpty ? 0 : 10)
            .background(.white)
            .cornerRadius(5)
            .offset(y: text.isEmpty ? 0 : -23)
            .scaleEffect(text.isEmpty ? 1 : 0.9, anchor: .leading)
    }
}
