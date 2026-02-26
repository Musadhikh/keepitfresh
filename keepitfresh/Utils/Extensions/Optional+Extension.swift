//
//
//  Optional+Extension.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: Optional+Extension <#brief summary#>
//
    

import Foundation

extension Optional {
    var isNil: Bool {
        return switch self {
            case .none: true
            case .some: false
        }
    }
    
    var isNotNil: Bool {
        return !isNil
    }
}
