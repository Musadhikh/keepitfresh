//
//  FirestoreCatalogRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Firestore-backed catalog repository stub kept optional and swappable.
//

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif
import Foundation

actor FirestoreCatalogRepository: CatalogRepository {
    func findLocal(barcode: Barcode) async throws -> ProductCatalogItem? {
        nil
    }

    func findRemote(barcode: Barcode) async throws -> ProductCatalogItem? {
        nil
    }

    func cacheLocal(_ item: ProductCatalogItem) async throws {
        // no-op for stub
    }
}
