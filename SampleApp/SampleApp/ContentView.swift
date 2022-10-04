//
//  ContentView.swift
//  SampleApp
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI
import Authentication

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Authentication") {
                    NavigationLink("Login") {
                        AuthView(viewType: .login)
                    }
                    NavigationLink("Register") {
                        AuthView(viewType: .registration)
                    }
                }
                
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
