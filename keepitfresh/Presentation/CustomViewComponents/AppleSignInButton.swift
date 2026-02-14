//
//  AppleSignInButton.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInButton: View {
    @State private var rawNonce = AppleSignInHelper.randomNonceString()
    
    let onCompletion: (Result<LoginType, Error>) -> Void
    
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            rawNonce = AppleSignInHelper.randomNonceString()
            request.requestedScopes = [.email, .fullName]
            request.nonce = AppleSignInHelper.sha256(rawNonce)
        } onCompletion: { result in
            switch result {
            case .success(let authorisation):
                onCompletion(.success(.apple(authorisation, rawNonce)))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
