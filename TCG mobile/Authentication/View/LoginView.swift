//
//  LoginView.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 24/04/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    @State private var securePassword: Bool = true
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8){
            Spacer()
            //MARK: - login Fields and button
            TextfieldWithIcon(systemName: "person.fill", placeholder: "please enter username", overlay: nil, text: $viewModel.username, isSecure: .constant(false))
                .padding(.vertical, 8)
                .textContentType(.username)
            TextfieldWithIcon(systemName: "lock.fill", placeholder: "please enter password", overlay: AnyView(Button(action: {
                securePassword.toggle()
            }) {
                Image(systemName: securePassword ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }), text: $viewModel.password, isSecure: $securePassword)
            .textContentType(.password)
            Button("forgot password?"){
                print("forgot password pressed")
            }
            .padding(8)
            .tint(Color.black)
            HStack{
                Button(action: {
                    viewModel.performLogin { (result: Bool) in
                        if result {
                            print("navigate to home screen")
                        }
                    }
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
            .alert(isPresented: $viewModel.shouldShowAlert) {
                Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
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
                    viewModel.handleGoogleSignInButton()
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
        .withLoading(isLoading: $viewModel.isLoading)
    }
}
    

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
