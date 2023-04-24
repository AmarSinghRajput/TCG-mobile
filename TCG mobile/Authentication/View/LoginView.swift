//
//  LoginView.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 24/04/23.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var securePassword: Bool = true
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8){
            Spacer()
            //MARK: - login Fields and button
            TextfieldWithIcon(systemName: "person.fill", placeholder: "please enter username", overlay: nil, text: $username, isSecure: .constant(false))
                .padding(.vertical, 8)
            TextfieldWithIcon(systemName: "lock.fill", placeholder: "please enter password", overlay: AnyView(Button(action: {
                securePassword.toggle()
            }) {
                Image(systemName: securePassword ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }), text: $password, isSecure: $securePassword)
            
            Button("forgot password?"){
                print("forgot password pressed")
            }
            .padding(8)
            .tint(Color.black)
            HStack{
                Button(action: {
                    print("Button tapped!")
                }) {
                    Text("Login")
                        .frame(alignment: .center)
                        .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                
            }
            .frame(maxWidth: .infinity, idealHeight: 50, maxHeight: 50, alignment: .center)
            //MARK: - seperator line
            HStack(alignment: .center, spacing: 10) {
                HorizontalLine()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 60, height: 1, alignment: .leading)
                Text("Or continue with")
                    .foregroundColor(.secondary)
                    
                HorizontalLine()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 60, height: 1, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 20)
            //MARK: - social buttons
            HStack(alignment: .center, spacing: 10){
                Spacer()
                Button(action: {
                    print("goole button tapped")
                }) {
                    Image("googleLogo")
                        .frame(width: 50, height: 50, alignment: .center)
                }
                Spacer()
                Button(action: {
                    print("fb button tapped")
                }) {
                    Image("fbLogo")
                        .frame(width: 50, height: 50, alignment: .center)
                }
                Spacer()
                Button(action: {
                    print("apple button tapped!")
                }) {
                    Image("appleLogo")
                        .frame(width: 50, height: 50, alignment: .center)
                }
                Spacer()
            }
            Spacer()
            
        }
        .padding([.horizontal], 30)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
