//
//  FirestoreCodableHelpers.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Codable helpers for Firestore dictionaries, timestamps, and document-id injection.
//

import FirebaseFirestore
import Foundation

enum FirestoreCodableHelpers {
    enum HelperError: Error {
        case missingSnapshotData
        case invalidJSONObject
    }

    static func decode<T: Decodable>(
        _ type: T.Type,
        from data: [String: Any],
        injectingDocumentIdTo idKey: String? = nil,
        documentId: String? = nil
    ) throws -> T {
        var payload = data
        if let idKey, let documentId, payload[idKey] == nil {
            payload[idKey] = documentId
        }

        let normalized = normalizeFirestoreValue(payload)
        guard JSONSerialization.isValidJSONObject(normalized) else {
            throw HelperError.invalidJSONObject
        }

        let jsonData = try JSONSerialization.data(withJSONObject: normalized)
        let decoder = makeDecoder()
        return try decoder.decode(type, from: jsonData)
    }

    static func decodeDocument<T: Decodable>(
        _ type: T.Type,
        from snapshot: DocumentSnapshot,
        injectingDocumentIdTo idKey: String? = nil
    ) throws -> T {
        guard let data = snapshot.data() else {
            throw HelperError.missingSnapshotData
        }

        return try decode(
            type,
            from: data,
            injectingDocumentIdTo: idKey,
            documentId: snapshot.documentID
        )
    }

    static func decodeProduct(from snapshot: DocumentSnapshot) throws -> Product {
        try decodeDocument(Product.self, from: snapshot, injectingDocumentIdTo: "id")
    }

    static func encode<T: Encodable>(_ value: T) throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        let data = try encoder.encode(value)
        let object = try JSONSerialization.jsonObject(with: data)

        guard let dictionary = object as? [String: Any] else {
            throw HelperError.invalidJSONObject
        }

        return convertDateMillisToTimestamp(dictionary) as? [String: Any] ?? dictionary
    }
}

private extension FirestoreCodableHelpers {
    static func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()

            if let milliseconds = try? container.decode(Double.self) {
                return Date(timeIntervalSince1970: milliseconds / 1000.0)
            }

            if let seconds = try? container.decode(Int64.self) {
                return Date(timeIntervalSince1970: TimeInterval(seconds))
            }

            if let text = try? container.decode(String.self) {
                if let date = parseISO8601Date(text) {
                    return date
                }
                if let date = parseYYYYMMDDDate(text) {
                    return date
                }
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unsupported date value for Firestore decoding."
            )
        }
        return decoder
    }

    static func normalizeFirestoreValue(_ value: Any) -> Any {
        if let timestamp = value as? Timestamp {
            return timestamp.dateValue().timeIntervalSince1970 * 1000.0
        }
        if let dictionary = value as? [String: Any] {
            return dictionary.mapValues(normalizeFirestoreValue)
        }
        if let array = value as? [Any] {
            return array.map(normalizeFirestoreValue)
        }
        return value
    }

    static func convertDateMillisToTimestamp(_ value: Any) -> Any {
        if let dictionary = value as? [String: Any] {
            return dictionary.mapValues(convertDateMillisToTimestamp)
        }
        if let array = value as? [Any] {
            return array.map(convertDateMillisToTimestamp)
        }
        if let milliseconds = value as? Double, isLikelyDateMilliseconds(milliseconds) {
            return Timestamp(date: Date(timeIntervalSince1970: milliseconds / 1000.0))
        }
        return value
    }

    static func isLikelyDateMilliseconds(_ value: Double) -> Bool {
        value >= 978_307_200_000 && value <= 4_102_444_800_000
    }

    static func parseISO8601Date(_ value: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: value) {
            return date
        }
        let fallback = ISO8601DateFormatter()
        fallback.formatOptions = [.withInternetDateTime]
        return fallback.date(from: value)
    }

    static func parseYYYYMMDDDate(_ value: String) -> Date? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: value)
    }
}
