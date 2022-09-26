//
//  LoginView.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI

@available(iOS 15.0, *)
public struct LoginView: View {
    
    public init() { }
   
    @StateObject private var viewModel = LoginViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView("Please wait")
            default:
                EmptyLogin(state: viewModel.viewState)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(viewModel.dismiss) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @ViewBuilder
    private func EmptyLogin(state: LoginViewModel.ViewState) -> some View {
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
                
                RememberEmail()
                
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
                self.viewModel.login()
            } label: {
                Text("Login")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .foregroundColor(.white)
            .background(viewModel.isButtonActive ? Color.green : Color.gray)
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
        LoginView()
    }
}
