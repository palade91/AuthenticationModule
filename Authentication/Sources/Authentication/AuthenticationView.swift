//
//  AuthenticationView.swift
//  
//
//  Created by Catalin Palade on 24/09/2022.
//

import SwiftUI

@available(iOS 13.0, *)
public struct AuthenticationView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            LoginView()
        }
    }
}

@available(iOS 13.0, *)
struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
