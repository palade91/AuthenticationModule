//
//  RegistrationViewModel.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import Foundation
import SwiftUI
import Combine
import LocalStorage

@available(iOS 15.0, *)
class RegistrationViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case loaded
    }
    
    @Published var viewState: ViewState = .loaded
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isButtonActive: Bool = false
    
    let dismiss = PassthroughSubject<Void, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    private let storage = LocalStorage()
    
    init() {
        observeCredentials()
    }
    
    func register() {
        self.viewState = .loading
        
//        let user = User(email: email, password: password)
//        storage.setValueStoreable(user, forKey: LocalStorageKeys.user)
        
        self.dismiss.send()
    }
    
    private func observeCredentials() {
        Publishers.CombineLatest($email, $password)
            .sink { _ in } receiveValue: { email, password in
                self.isButtonActive = !email.isEmpty && !password.isEmpty
            }.store(in: &cancellable)
    }
}
