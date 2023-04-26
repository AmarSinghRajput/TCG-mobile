//
//  ProductListingView.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 26/04/23.
//

import SwiftUI

struct ProductListingView: View {
    @ObservedObject var viewModel: ProductListingViewModel
    
    init(viewModel: ProductListingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("This would be our product listing page!")
    }
}

struct ProductListingView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListingView(viewModel: ProductListingViewModel())
    }
}
