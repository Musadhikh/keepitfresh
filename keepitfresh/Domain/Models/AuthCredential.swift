//
//  AuthCredential.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

enum AuthCredential {
    case google(idToken: String, accessToken: String)
    case apple(token: String, nonce: String)
    case emailPassword(email: String, password: String)
    case anonymous
}

enum AuthProviderType: String, CaseIterable {
    case google = "google"
    case apple = "apple"
    case emailPassword = "email_password"
    case anonymous = "anonymous"
}
