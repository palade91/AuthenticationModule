//
//  LoginViewModel.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import Foundation
import SwiftUI
import Combine
import LocalStorage

@available(iOS 15.0, *)
class LoginViewModel: ObservableObject {
    
    enum ViewState {
        case empty
        case loading
        case fail
    }
    
    @Published var viewState: ViewState = .empty
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var isButtonActive: Bool = false
    
    let dismiss = PassthroughSubject<Void, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    private let storage = LocalStorage()
    
    init() {
        observeCredentials()
    }
    
    func login() {
        self.viewState = .loading
        let user: User? = storage.getValueStoreable(forKey: LocalStorageKeys.user)
        let currentUser = User(username: username, password: password)
        
        if let user = user, user == currentUser {
            dismiss.send()
        } else {
            viewState = .fail
        }
    }
    
    private func observeCredentials() {
        Publishers.CombineLatest($username, $password)
            .sink { _ in } receiveValue: { username, password in
                self.isButtonActive = !username.isEmpty && !password.isEmpty
            }.store(in: &cancellable)
    }
}
