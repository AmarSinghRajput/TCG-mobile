//
//  NavigationManager.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 26/04/23.
//
import Foundation
import SwiftUI

enum NavigationRoutes: String {
    case login = "login"
    case productListing = "productListing"

//** currently not being used will consider improving and implementing in case our deployment target goes below iOS16
//    //for passing path to navigation Path
//    var pathName: String {
//        switch self {
//        case .login(_) :
//            return "login"
//        case .productListing(_) :
//            return "productListing"
//        }
//    }
//
//    var view: AnyView {
//        switch self {
//        case .login(let viewModel):
//            return AnyView(LoginView(viewModel: viewModel))
//        case .productListing(let viewModel):
//            return AnyView(ProductListingView(viewModel: viewModel))
//        }
//    }
}
