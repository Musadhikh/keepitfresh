//
//  AuthCredential+Extension.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation
import FirebaseAuth

extension AuthCredential {
    var firebaseCredential: FirebaseAuth.AuthCredential? {
        switch self {
        case .google(let idToken, let accessToken):
            return GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
        case .apple(let token, let nonce):
            return OAuthProvider.appleCredential(withIDToken: token, rawNonce: nonce, fullName: nil)
            
        case .emailPassword(let email, let password):
            return EmailAuthProvider.credential(withEmail: email, password: password)
            
        case .anonymous:
            return nil // Anonymous sign-in doesn't use credentials
            
        @unknown default:
            return nil
        }
    }
}
