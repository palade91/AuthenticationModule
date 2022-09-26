//
//  SampleAppApp.swift
//  SampleApp
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI
import Firebase

@main
struct SampleAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
