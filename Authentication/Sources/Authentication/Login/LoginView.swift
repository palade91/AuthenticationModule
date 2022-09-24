//
//  LoginView.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI

@available(iOS 13.0, *)
public struct LoginView: View {
   
    @StateObject private var viewModel = LoginViewModel()
    
    public init() { }
    
    public var body: some View {
        switch viewModel.viewState {
        case .loading:
            Text("Loading...")
        case .fail:
            Text("Failed")
        case .loaded:
            Text("Loaded")
        }
    }
}

@available(iOS 13.0, *)
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
