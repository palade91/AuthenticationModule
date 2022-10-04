//
//  SampleAppApp.swift
//  SampleApp
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI
import Firebase
import Authentication

@main
struct SampleAppApp: App {
    
    init() {
        FirebaseApp.configure()
        
        // Authentication config
        Authentication.inject(brandColor: UIColor.red)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
