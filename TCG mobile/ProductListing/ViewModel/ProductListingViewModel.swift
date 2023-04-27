//
//  ProductListingViewModel.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 26/04/23.
//

import Foundation
import SwiftUI

class ProductListingViewModel: ObservableObject {
    @Published var path: NavigationPath
    @Published var shouldShowAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var isLoading = false
    @AppStorage(AppStorageKey.authToken) var authToken: String = ""
    
    init(navigationPath: NavigationPath) {
        self.path = navigationPath
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        isLoading = true
        let param = "refresh_token=\(authToken)"
        APIHelper.shared.post(endpoint: .login, data: param) { [weak self] (result: Result<ProductListingResponse, APIError>) in
            switch result {
            case .success(let data):
                print("\(String(describing: data.access_token))")
                if let token = data.access_token {
                    DispatchQueue.main.async {
                        self?.authToken = token
                    }
                }
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

