// TestSupport/Stubs.swift
// Target: keepitfreshTests

import Foundation
@testable import keepitfresh

enum TestError: Error, Sendable {
    case boom(String)
}

struct AppMetadataProviderStub: AppMetadataProviding, Sendable {
    var result: Result<AppMetadata, TestError>
    func getAppMetadata() async throws -> AppMetadata { try result.get() }
}

struct VersionCheckProviderStub: VersionCheckProviding, Sendable {
    var requiresUpdate: Bool = false
    func requiresVersionUpdate(metadata: AppMetadata) -> Bool { requiresUpdate }
}

struct UserProviderStub: UserProviding, Sendable {
    var currentResult: Result<keepitfresh.User?, TestError> = .success(nil)
    var validateResult: Result<Void, TestError> = .success(())
    func current() async throws -> keepitfresh.User? { try currentResult.get() }
    func validateSession() async throws { _ = try validateResult.get() }
}

struct UserProfileProviderStub: ProfileProviding, Sendable {
    var result: Result<Profile, TestError>
    
    func getProfile(for userId: String) async throws -> keepitfresh.Profile? {
        try result.get()
    }

    func create(profile: keepitfresh.Profile) async throws {
        
    }

    func update(profile: keepitfresh.Profile) async throws {
        
    }

    func delete(userId: String) async throws {
        
    }
}
