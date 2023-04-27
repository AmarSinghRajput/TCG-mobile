//
//  ProductListingView.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 26/04/23.
//

import SwiftUI

struct ProductListingView: View {
    @ObservedObject var viewModel: ProductListingViewModel
    let products = (1...20).map { "Product \($0)" }
    
    init(viewModel: ProductListingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack{
            List(products, id: \.self) { text in
                Text(text)
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("refreshToken") {
                        viewModel.refreshToken { result in
                            print(result)
                        }
                    }
                    .alert(isPresented: $viewModel.shouldShowAlert) {
                        Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .withLoading(isLoading: $viewModel.isLoading)
        }
    }
}

struct ProductListingView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListingView(viewModel: ProductListingViewModel(navigationPath: NavigationPath()))
    }
}
