//
//  LoginViewModel.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 24/04/23.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isUsernameValid = false
    @Published var isPasswordValid = false
    @Published var shouldShowAlert = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var isLoading = false
    //used for deallocating any subscription to avoid memory leaks
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        //here we are subscribing to username,pass for changes and checking validations
        Publishers.CombineLatest($username, $password)
            .sink { [weak self] username, password in
                self?.isUsernameValid = ValidationsHelper.isValidUsername(name: username)
                self?.isPasswordValid = ValidationsHelper.isValidPassword(pass: password)
            }.store(in: &cancellableSet)
    }
    
    func performLogin(completion: @escaping (Bool) -> Void) {
        if !self.isUsernameValid {
            shouldShowAlert = true
            alertTitle = Alerts.invalidUsernameTitle
            alertMessage = Alerts.invalidUsernameMessage
            completion(false)
            
        }else if !self.isPasswordValid {
            shouldShowAlert = true
            alertTitle = Alerts.invalidPassTitle
            alertMessage = Alerts.invalidPassMessage
            completion(false)
            
        }else {
            isLoading = true
            let params = "username=\(username)&password=\(password)"
            APIHelper.shared.post(endpoint: .login, data: params) { [weak self] (result: Result<LoginResponse, APIError>) in
                switch result {
                case .success(let data):
                    print("\(String(describing: data.access_token))")
                    DispatchQueue.main.async {
                        self?.shouldShowAlert = false
                        self?.isLoading = false
                    }
                    completion(true)
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.shouldShowAlert = true
                        self?.alertTitle = "something went wrong"
                        self?.alertMessage = error.localizedDescription
                        self?.isLoading = false
                    }
                    completion(false)
                }
            }
        }
    }
}
