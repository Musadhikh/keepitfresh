//
//
//  ModelStringConvertible.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: ModelStringConvertible
//
    
import Foundation

protocol ModelStringConvertible: CustomStringConvertible { }

extension ModelStringConvertible {
    var description: String {
        if let rawRepresentable = self as? any RawRepresentable {
            return "\(type(of: self))(\(rawRepresentable.rawValue))"
        }
        
        let mirror = Mirror(reflecting: self)
        let properties = mirror.children.compactMap { child -> String? in
            guard let label = child.label else {
                return nil
            }
            
            return "\(label): \(child.value)"
        }
        return "\(type(of: self))\n\(properties.joined(separator: ", "))"
    }
}
