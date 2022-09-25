//
//  AuthenticationView.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI

@available(iOS 15.0, *)
public struct AuthenticationView: View {
    
    public init() {}
    
    @State private var showLogin: Bool = false
    @State private var showRegistration: Bool = false
    
    public var body: some View {
        List {
            Section("Authentication") {
                Button {
                    showLogin = true
                } label: {
                    Text("Login")
                }
                
                Button {
                    showRegistration = true
                } label: {
                    Text("Registration")
                }
            }
            
//            Section("Status") {
//                Button {
//                    
//                } label: {
//                    Text("Sign out")
//                }
//            }
            
        }
        .sheet(isPresented: $showLogin) {
            LoginView()
        }
        .sheet(isPresented: $showRegistration) {
            RegistrationView()
        }
    }
}

@available(iOS 15.0, *)
struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
