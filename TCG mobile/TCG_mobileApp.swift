//
//  TCG_mobileApp.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 24/04/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@main
struct TCG_mobileApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
