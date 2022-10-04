//
//  AuthView.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI
import UIKit

@available(iOS 15.0, *)
public struct AuthView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: AuthViewModel
    
    public init(viewType: AuthViewModel.ViewType) {
        self.viewModel = AuthViewModel(viewType: viewType)
    }
    
    private let brandColor: UIColor = Authentication.brandColor
   
    public var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView("Please wait")
            default:
                DefaultAuthView(
                    state: viewModel.viewState,
                    viewType: viewModel.viewType
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(viewModel.dismiss) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @ViewBuilder
    private func DefaultAuthView(
        state: AuthViewModel.ViewState,
        viewType: AuthViewModel.ViewType
    ) -> some View {
        VStack(alignment: .center, spacing: 40) {
            VStack(alignment: .center, spacing: 20) {
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .frame(height: 40)
                    .border(viewModel.email.isEmpty ? .red : .green, width: 2)
                    .cornerRadius(4)
                    .multilineTextAlignment(.center)
                
                if viewType == .login {
                    RememberEmail()
                }
                
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
                    .frame(height: 40)
                    .border(viewModel.password.isEmpty ? .red : .green, width: 2)
                    .cornerRadius(4)
                    .multilineTextAlignment(.center)
                
            }.padding(.horizontal, 20)
            
            if state == .fail {
                Text("The email or password are incorrect. Please try again!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.red)
            }
            
            Button {
                self.viewModel.action()
            } label: {
                Text(viewType == .login ? "Login" : "Register")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .foregroundColor(.white)
            .background(viewModel.isButtonActive ? Color(uiColor: brandColor) : Color.gray)
            .cornerRadius(4)
            .disabled(!viewModel.isButtonActive)
        }
        .padding()
    }
    
    @ViewBuilder
    private func RememberEmail() -> some View {
        Toggle(isOn: $viewModel.rememberEmail) {
            Text("Remember Email")
        }.toggleStyle(CheckboxToggleStyle())
    }
}

@available(iOS 15, *)
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(viewType: .login)
    }
}
