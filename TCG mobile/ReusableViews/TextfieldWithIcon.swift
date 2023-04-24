//
//  TextfieldWithIcon.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 24/04/23.
//

import SwiftUI

struct TextfieldWithIcon: View {
    let systemName: String
    let placeholder: String
    let overlay: AnyView?
    @Binding var text: String
    @Binding var isSecure: Bool
    
    var body: some View {
        HStack{
            Image(systemName: systemName)
                .foregroundColor(.gray)
                .padding(.leading, 8)
            if isSecure {
                ZStack(alignment: .trailing) {
                    SecureField(placeholder, text: $text)
                    if let overlay = overlay {
                        overlay
                    }
                }
            } else {
                ZStack(alignment: .trailing) {
                    TextField(placeholder, text: $text)
                    if let overlay = overlay {
                        overlay
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct TextfieldWithIcon_Previews: PreviewProvider {
    @State private var text: String = ""
    
    static var previews: some View {
        TextfieldWithIcon(systemName: "person", placeholder: "enter username", overlay: AnyView(Button("Press"){
            print("hello")
        }), text: .constant(""), isSecure: .constant(true))
    }
}

