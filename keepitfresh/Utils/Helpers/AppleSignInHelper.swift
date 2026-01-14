//
//  AppleSignInHelper.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import Foundation
import CryptoKit

struct AppleSignInHelper {
    private init() {}
    
    static func randomNonceString(length: Int = 32) -> String? {
        if length == 0 { return nil }
        
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        guard errorCode == errSecSuccess else {
            return nil
        }
        
        let charset: [Character] = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._")
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        
        let hashedData = SHA256.hash(data: inputData)
        let hashedString = hashedData.map {
            String(format: "%02x", $0)
        }.joined()
        
        return hashedString
    }
}
