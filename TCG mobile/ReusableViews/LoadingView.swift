//
//  LoadingView.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 25/04/23.
//

import Foundation
import SwiftUI

struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
            if isLoading {
                ProgressView()
                    .tint(.red)
                    .scaleEffect(2.0)
            }
        }
    }
}

extension View {
    func withLoading(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
