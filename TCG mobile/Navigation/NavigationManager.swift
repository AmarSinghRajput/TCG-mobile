//
//  NavigationManager.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 26/04/23.
//
import Foundation
import SwiftUI

enum NavigationRoutesProvider {
    case login(viewModel: LoginViewModel)
    case productListing(viewModel: ProductListingViewModel)
    
    //for passing path to navigation Path
    var pathName: String {
        switch self {
        case .login(_) :
            return "login"
        case .productListing(_) :
            return "productListing"
        }
    }
    
    //for getting view
    var view: AnyView {
        switch self {
        case .login(let viewModel):
            return AnyView(LoginView(viewModel: viewModel))
        case .productListing(let viewModel):
            return AnyView(ProductListingView(viewModel: viewModel))
        }
    }
}
