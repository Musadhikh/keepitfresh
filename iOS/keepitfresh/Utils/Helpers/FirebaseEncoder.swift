//
//  FirebaseEncoder.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 16/1/26.
//

import FirebaseFirestore
import Foundation

/// Encodes `Encodable` types into Firebase-compatible dictionaries.
/// Automatically converts `Date` values to Firebase `Timestamp`.
struct FirebaseEncoder {
    
    /// Encoding error types
    enum EncodingError: Error {
        case invalidValue(String)
        case encodingFailed(String)
    }
    
    // MARK: - Public Methods
    
    /// Encodes an `Encodable` value into a Firebase-compatible dictionary.
    /// - Parameter value: The value to encode
    /// - Returns: A dictionary with String keys and Any values
    /// - Throws: EncodingError if encoding fails
    func encode<T: Encodable>(_ value: T) throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        
        let data = try encoder.encode(value)
        
        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw EncodingError.encodingFailed("Failed to convert to dictionary")
        }
        
        guard let result = convertDatesToTimestamps(jsonObject) as? [String: Any] else {
            throw EncodingError.encodingFailed("Failed to convert to dictionary")
        }
        
        return result
    }
    
    // MARK: - Private Methods
    
    /// Recursively converts Date values (stored as milliseconds) to Firebase Timestamps
    /// - Parameter value: The value to convert
    /// - Returns: The converted value with Timestamps instead of Date milliseconds
    private func convertDatesToTimestamps(_ value: Any) -> Any {
        if let dictionary = value as? [String: Any] {
            return dictionary.mapValues { convertDatesToTimestamps($0) }
        } else if let array = value as? [Any] {
            return array.map { convertDatesToTimestamps($0) }
        } else if let milliseconds = value as? Double {
            // Check if this looks like a timestamp (reasonable date range)
            // Dates between year 2001 and 2100 in milliseconds
            let minTimestamp: Double = 978307200000  // Jan 1, 2001
            let maxTimestamp: Double = 4102444800000 // Jan 1, 2100
            
            if milliseconds >= minTimestamp && milliseconds <= maxTimestamp {
                let seconds = milliseconds / 1000.0
                let nanoseconds = Int32((milliseconds.truncatingRemainder(dividingBy: 1000)) * 1_000_000)
                return Timestamp(seconds: Int64(seconds), nanoseconds: nanoseconds)
            }
        }
        
        return value
    }
}

// MARK: - Convenience Extension

extension Encodable {
    /// Encodes the value to a Firebase-compatible dictionary
    /// - Returns: A dictionary representation suitable for Firebase
    /// - Throws: FirebaseEncoder.EncodingError if encoding fails
    func toFirebaseDictionary() throws -> [String: Any] {
        let encoder = FirebaseEncoder()
        return try encoder.encode(self)
    }
}
