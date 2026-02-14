//
//  Error+Extension.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Adds ergonomic Error helpers that expose NSError-backed metadata like code and domain.
//

import Foundation

extension Error {
    /// Bridged Foundation error for metadata access.
    var nsError: NSError {
        self as NSError
    }
    
    /// Numeric code for this error.
    var errorCode: Int {
        nsError.code
    }
    
    /// Domain for this error.
    var errorDomain: String {
        nsError.domain
    }
    
    /// Failure reason if provided by the underlying error.
    var failureReason: String? {
        nsError.localizedFailureReason
    }
    
    /// Recovery suggestion if provided by the underlying error.
    var recoverySuggestion: String? {
        nsError.localizedRecoverySuggestion
    }
}
