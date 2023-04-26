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
    
    init(navigationPath: NavigationPath) {
        self.path = navigationPath
    }

}

