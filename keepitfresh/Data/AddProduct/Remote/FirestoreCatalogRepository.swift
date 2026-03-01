//
//  FirestoreCatalogRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Firestore-backed catalog repository adapter for ProductCatalog reads/writes.
//

import FirebaseFirestore
import Foundation

actor FirestoreCatalogRepository: CatalogRepository {
    private let db: Firestore

    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }

    func findLocal(barcode: Barcode) async throws -> ProductCatalogItem? {
        nil
    }

    func findRemote(barcode: Barcode) async throws -> ProductCatalogItem? {
        guard let normalizedBarcode = Self.normalizedBarcode(barcode.value) else {
            return nil
        }

        // Primary lookup: canonical ProductCatalog doc id == product id / normalized barcode.
        let canonicalSnapshot = try await productCatalogCollection()
            .document(normalizedBarcode)
            .getDocument()
        if canonicalSnapshot.exists {
            return mapCatalogItem(from: canonicalSnapshot, fallbackBarcode: normalizedBarcode, fallbackSymbology: barcode.symbology)
        }

        // Fallback lookup by stored barcode field (for documents not keyed by barcode).
        let snapshot = try await productCatalogCollection()
            .whereField("barcode", isEqualTo: normalizedBarcode)
            .limit(to: 1)
            .getDocuments()
        guard let first = snapshot.documents.first else {
            return nil
        }
        return mapCatalogItem(from: first, fallbackBarcode: normalizedBarcode, fallbackSymbology: barcode.symbology)
    }

    func fetchAllLocal() async throws -> [ProductCatalogItem] {
        []
    }

    func cacheLocal(_ item: ProductCatalogItem) async throws {
        // no-op for stub
    }

    func upsertRemote(_ item: ProductCatalogItem) async throws {
        guard let normalizedBarcode = Self.normalizedBarcode(item.barcode.value) else {
            throw CatalogRepositoryError.unknown
        }

        if FirebaseWritePolicy.isMockWriteEnabled {
            return
        }

        let payload: [String: Any] = [
            "id": item.id,
            "productId": item.id,
            "barcode": normalizedBarcode,
            "barcodeSymbology": item.barcode.symbology.rawValue,
            "title": item.title as Any,
            "name": item.title as Any,
            "brand": item.brand as Any,
            "description": item.description as Any,
            "images": item.images?.map(\.absoluteString) as Any,
            "imageUrl": item.images?.first?.absoluteString as Any,
            "categories": item.categories as Any,
            "size": item.size as Any,
            "updatedAt": Timestamp(date: Date())
        ]

        try await productCatalogCollection()
            .document(item.id.isEmpty ? normalizedBarcode : item.id)
            .setData(payload, merge: true)
    }
}

private extension FirestoreCatalogRepository {
    func productCatalogCollection() -> CollectionReference {
        db.collection(FirebaseConstants.Collections.productCatalog)
    }

    func mapCatalogItem(
        from snapshot: DocumentSnapshot,
        fallbackBarcode: String,
        fallbackSymbology: Barcode.Symbology
    ) -> ProductCatalogItem? {
        let data = snapshot.data() ?? [:]

        let barcodeValue = Self.normalizedBarcode(data["barcode"] as? String) ?? fallbackBarcode
        let symbologyRaw = data["barcodeSymbology"] as? String
        let symbology = Barcode.Symbology(value: symbologyRaw) == .unknown ? fallbackSymbology : Barcode.Symbology(value: symbologyRaw)

        let title = Self.stringValue(data, keys: ["title", "name"])
        let brand = Self.stringValue(data, keys: ["brand"])
        let description = Self.stringValue(data, keys: ["description", "shortDescription"])
        let size = Self.stringValue(data, keys: ["size", "productDetails.quantity"])

        let categories = Self.arrayStringValue(data, keys: ["categories", "categoryPath"])
        let images = Self.imageURLs(data)

        return ProductCatalogItem(
            id: snapshot.documentID,
            barcode: Barcode(value: barcodeValue, symbology: symbology),
            title: title,
            brand: brand,
            description: description,
            images: images.isEmpty ? nil : images,
            categories: categories.isEmpty ? nil : categories,
            size: size
        )
    }

    static func normalizedBarcode(_ value: String?) -> String? {
        guard let value else { return nil }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    static func stringValue(_ data: [String: Any], keys: [String]) -> String? {
        for key in keys {
            if key.contains(".") {
                if let nested = nestedValue(data: data, keyPath: key) as? String {
                    let trimmed = nested.trimmingCharacters(in: .whitespacesAndNewlines)
                    if trimmed.isNotEmpty {
                        return trimmed
                    }
                }
                continue
            }
            if let value = data[key] as? String {
                let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.isNotEmpty {
                    return trimmed
                }
            }
        }
        return nil
    }

    static func arrayStringValue(_ data: [String: Any], keys: [String]) -> [String] {
        for key in keys {
            if let values = data[key] as? [String] {
                let normalized = values
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .filter(\.isNotEmpty)
                if normalized.isNotEmpty {
                    return normalized
                }
            }
        }
        return []
    }

    static func imageURLs(_ data: [String: Any]) -> [URL] {
        if let urls = data["images"] as? [String] {
            let mapped = urls.compactMap(URL.init(string:))
            if mapped.isNotEmpty {
                return mapped
            }
        }

        if let imageURL = data["imageUrl"] as? String,
           let url = URL(string: imageURL)
        {
            return [url]
        }

        return []
    }

    static func nestedValue(data: [String: Any], keyPath: String) -> Any? {
        keyPath.split(separator: ".").reduce(data as Any?) { partial, segment in
            guard let dictionary = partial as? [String: Any] else { return nil }
            return dictionary[String(segment)]
        }
    }
}
