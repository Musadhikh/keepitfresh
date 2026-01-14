//
//  AppleSignInButton.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInButton: View {
    @State private var rawNonce: String?
    @State private var isNonceGenerated: Bool = false
    
    var onCompletion: (Result<LoginType, Error>) -> Void
    
    var body: some View {
        if let rawNonce {
            SignInWithAppleButton(.signIn) { request in
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
        } else if isNonceGenerated {
            Text("Unable to Sign in With Apple")
        } else {
            Text("Preparing...")
                .onAppear {
                    let nonce = AppleSignInHelper.randomNonceString()
                    isNonceGenerated = true
                    rawNonce = nonce
                }
        }
    }
}
