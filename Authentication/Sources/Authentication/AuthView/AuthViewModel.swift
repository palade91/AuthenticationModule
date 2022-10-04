//
//  AuthViewModel.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import Foundation
import SwiftUI
import Combine
import LocalStorage
import Firebase

@available(iOS 15.0, *)
public class AuthViewModel: ObservableObject {
    
    enum ViewState {
        case empty
        case loading
        case fail
    }
    
    public enum ViewType {
        case login
        case registration
    }
    
    @Published var viewState: ViewState = .empty
    @Published var viewType: ViewType
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var rememberEmail: Bool = false
    @Published var isButtonActive: Bool = false
    
    let dismiss = PassthroughSubject<Void, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    private let storage = LocalStorage()
    
    init(viewType: ViewType) {
        self.viewType = viewType
        
        self.observeCredentials()
        self.observeRememberEmail()
    }
    
    func action() {
        self.viewState = .loading
        
        switch viewType {
        case .login:
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self?.viewState = .fail
                } else {
                    self?.dismiss.send()
                }
            }
        case .registration:
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self?.viewState = .fail
                } else {
                    self?.dismiss.send()
                }
            }
        }
    }
    
    private func observeCredentials() {
        Publishers.CombineLatest($email, $password)
            .sink { _ in } receiveValue: { email, password in
                self.isButtonActive = !email.isEmpty && !password.isEmpty
            }.store(in: &cancellable)
    }
    
    private func observeRememberEmail() {
        let email: String? = storage.getValue(forKey: LocalStorageKeys.email)
        
        self.email = email ?? ""
        self.rememberEmail = email != nil
        
        $rememberEmail.sink { [weak self] value in
            if value {
                self?.storage.setValue(self?.email, forKey: LocalStorageKeys.email)
            } else {
                self?.storage.remove(key: LocalStorageKeys.email)
            }
        }.store(in: &cancellable)
    }
}
