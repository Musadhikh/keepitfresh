// AppLaunchUseCaseTests.swift
// Target: keepitfreshTests

import Foundation
import Testing
@testable import keepitfresh

@Suite("AppLaunchUseCase")
struct AppLaunchUseCaseTests {
    
    // MARK: - Routing Outcomes
    
    @Test("Returns .maintenance when app is under maintenance")
    func maintenance() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            metadata: .success(Fixtures.metadataMaintenance),
            requiresUpdate: true // ignored due to maintenance precedence
        ).build()
        
        let state = try await useCase.execute()
        #expect(state == .maintenance)
    }
    
    @Test("Returns .updateRequired when version check fails")
    func updateRequired() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            metadata: .success(Fixtures.metadataOK),
            requiresUpdate: true
        ).build()
        
        let state = try await useCase.execute()
        #expect(state == .updateRequired)
    }
    
    @Test("Returns .loginRequired when no current user")
    func loginRequired() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            metadata: .success(Fixtures.metadataOK),
            requiresUpdate: false,
            user: .success(nil)
        ).build()
        
        let state = try await useCase.execute()
        #expect(state == .loginRequired)
    }
    
    @Test("Returns .createHousehold when user has no households")
    func createHousehold() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            user: .success(Fixtures.user),
            profile: .success(Fixtures.profile(households: [], lastSelected: nil))
        ).build()
        
        let state = try await useCase.execute()
        #expect(state == .createHousehold)
    }
    
    @Test("Returns .selectHousehold when no last selected household")
    func selectHousehold() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            user: .success(Fixtures.user),
            profile: .success(Fixtures.profile(households: ["h1", "h2"], lastSelected: nil))
        ).build()
        
        let state = try await useCase.execute()
        #expect(state == .selectHousehold)
    }
    
    @Test("Returns .mainContent when context is valid")
    func mainContent() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            user: .success(Fixtures.user),
            profile: .success(Fixtures.profile(households: ["h1"], lastSelected: "h1"))
        ).build()
        
        let state = try await useCase.execute()
        #expect(state == .mainContent)
    }
    
    // MARK: - Error Propagation
    
    @Test("Throws when metadata provider fails")
    func metadataError() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            metadata: .failure(.boom("metadata"))
        ).build()
        
        do {
            _ = try await useCase.execute()
            #expect(false, "Expected execute() to throw when metadata fails")
        } catch {
            #expect(true) // any error acceptable
        }
    }
    
    @Test("Throws when validateSession fails")
    func validateSessionError() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            user: .success(Fixtures.user),
            validate: .failure(.boom("validate"))
        ).build()
        
        do {
            _ = try await useCase.execute()
            #expect(false, "Expected execute() to throw when validateSession fails")
        } catch {
            #expect(true)
        }
    }
    
    @Test("Throws when profile provider fails")
    func profileError() async throws {
        let useCase = AppLaunchUseCaseBuilder(
            user: .success(Fixtures.user),
            profile: .failure(.boom("profile"))
        ).build()
        
        do {
            _ = try await useCase.execute()
            #expect(false, "Expected execute() to throw when profile fetch fails")
        } catch {
            #expect(true)
        }
    }
}
