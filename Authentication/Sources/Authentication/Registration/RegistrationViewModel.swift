//
//  RegistrationViewModel.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
class RegistrationViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case fail
        case loaded
    }
    
    @Published var viewState: ViewState = .loading
    
    init() {
        loadData()
    }
    
    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewState = .loaded
        }
    }
}
