//
//  AuthenticationView.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI
import LocalStorage

@available(iOS 15.0, *)
public struct AuthenticationView: View {
    
    public init() {}
    
    @State private var showLogin: Bool = false
    @State private var showRegistration: Bool = false
    @State private var showSignOut: Bool = false
    
    private let storage = LocalStorage()
    
    public var body: some View {
        List {
            if showSignOut {
                Section("Status") {
                    Button {
//                        self.storage.remove(key: LocalStorageKeys.user)
                        self.showSignOut = false
                    } label: {
                        Text("Sign out")
                    }
                }
            } else {
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
            }
        }
        .onAppear {
//            let user: User? = storage.getValueStoreable(forKey: LocalStorageKeys.user)
//            self.showSignOut = user != nil
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
