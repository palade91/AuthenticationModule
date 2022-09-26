//
//  RegistrationView.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI

@available(iOS 15.0, *)
public struct RegistrationView: View {
    
    public init() { }
    
    @StateObject private var viewModel = RegistrationViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView("Please wait")
            case .loaded:
                EmptyRegistration()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(viewModel.dismiss) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @ViewBuilder
    private func EmptyRegistration() -> some View {
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
                
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.newPassword)
                    .frame(height: 40)
                    .border(viewModel.password.isEmpty ? .red : .green, width: 2)
                    .cornerRadius(4)
                    .multilineTextAlignment(.center)
                
            }.padding(.horizontal, 20)
            
            Button {
                self.viewModel.register()
            } label: {
                Text("Register")
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
}

@available(iOS 15.0, *)
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
