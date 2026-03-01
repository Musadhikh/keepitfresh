//
//  LoginType.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import AuthenticationServices

enum LoginType: Sendable {
    case apple(ASAuthorization, String?)
    case google(UIViewController)
    case anonymous
    
    func provider() -> any AuthProviding {
        switch self {
        case .apple(let authorization, let nonce):
            return AppleAuthProvider(nonce: nonce, authorization: authorization)
        case .google(let viewController):
            return GoogleSignInProvider(viewController: viewController)
        case .anonymous:
            return AnonymousAuthProvider()
            
        }
    }
}
