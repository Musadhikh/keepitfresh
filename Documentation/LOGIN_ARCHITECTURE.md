# Extensible Login Flow Architecture

## Overview
This document describes the extensible login flow architecture for KeepItFresh. The architecture supports multiple authentication methods using the **Strategy Pattern** and follows **Clean Architecture** principles.

## Supported Login Methods
- ✅ Email & Password
- ✅ Email with OTP
- ✅ Mobile with OTP
- ✅ Google Sign-In
- ✅ Apple Sign-In
- ✅ Anonymous (Guest)

## Architecture Layers

### 1. Domain Layer (`Domain/Authentication/`)

#### Models
- **`LoginCredential`**: Input credentials from the user
- **`AuthenticationResult`**: Result of successful authentication
- **`OTPRequest`**: Request to send OTP (email or mobile)
- **`OTPRequestResult`**: Response from OTP request

#### Ports (Protocols)
- **`AuthenticationStrategyProviding`**: Base protocol for all auth strategies
- **`EmailPasswordAuthStrategyProviding`**: Email/password authentication
- **`OTPAuthStrategyProviding`**: OTP-based authentication
- **`SocialAuthStrategyProviding`**: Social authentication (Google, Apple)
- **`AnonymousAuthStrategyProviding`**: Anonymous authentication
- **`AuthenticationCoordinatorProviding`**: Coordinates all strategies

#### Use Cases
- **`LoginUseCase`**: Execute login with credentials
- **`RequestOTPUseCase`**: Request OTP for email or mobile
- **`SignOutUseCase`**: Sign out current user

### 2. Data Layer (`Data/Authentication/`)

**Note**: Implementations go here (not included in this structure)

Each strategy protocol would have a concrete implementation:
- `EmailPasswordAuthStrategy`
- `EmailOTPAuthStrategy`
- `MobileOTPAuthStrategy`
- `GoogleAuthStrategy`
- `AppleAuthStrategy`
- `AnonymousAuthStrategy`
- `AuthenticationCoordinator`

### 3. Presentation Layer (`Presentation/Login/`)

- **`LoginViewModel`**: Manages login flow state and user actions
- **`LoginViewState`**: State types for the login flow
- **`LoginCoordinator`**: Navigation coordinator for login screens
- **`LoginView`**: SwiftUI views (to be implemented)

## How to Add a New Login Method

### Step 1: Extend Domain Models
Add new case to `LoginCredential`:
```swift
enum LoginCredential: Sendable {
    // ... existing cases
    case biometric(token: String)  // New method
}
```

Add to `AuthProviderType`:
```swift
enum AuthProviderType: String, CaseIterable, Sendable {
    // ... existing cases
    case biometric = "biometric"
}
```

### Step 2: Create Strategy Protocol (if needed)
If the new method has unique behavior, create a protocol:
```swift
protocol BiometricAuthStrategyProviding: AuthenticationStrategyProviding {
    func authenticateWithBiometric() async throws -> AuthenticationResult
}
```

### Step 3: Implement Strategy (Data Layer)
Create concrete implementation:
```swift
struct BiometricAuthStrategy: BiometricAuthStrategyProviding {
    var providerType: AuthProviderType { .biometric }
    
    func authenticate(with credential: LoginCredential) async throws -> AuthenticationResult {
        // Implementation
    }
}
```

### Step 4: Register Strategy
Register with coordinator at app startup:
```swift
let biometricStrategy = BiometricAuthStrategy()
authCoordinator.register(strategy: biometricStrategy)
```

### Step 5: Update Presentation Layer
Add to `LoginMethod` enum:
```swift
enum LoginMethod: Sendable, CaseIterable {
    // ... existing cases
    case biometric
}
```

Add method to `LoginViewModel`:
```swift
func loginWithBiometric() async {
    let credential = LoginCredential.biometric(token: "...")
    await performLogin(with: credential)
}
```

## Flow Diagrams

### Email/Password Login Flow
```
User → LoginView 
    → LoginViewModel.loginWithEmailPassword() 
    → LoginUseCase.execute()
    → AuthenticationCoordinator.authenticate()
    → EmailPasswordAuthStrategy.authenticate()
    → AuthenticationResult
```

### OTP Login Flow
```
User → LoginView (Enter Email/Mobile)
    → LoginViewModel.requestEmailOTP()
    → RequestOTPUseCase.execute()
    → OTPAuthStrategy.requestOTP()
    → OTPRequestResult

User → OTPView (Enter OTP)
    → LoginViewModel.verifyOTP()
    → LoginUseCase.execute()
    → AuthenticationCoordinator.authenticate()
    → OTPAuthStrategy.verifyOTP()
    → AuthenticationResult
```

### Social Login Flow
```
User → LoginView (Tap Google/Apple)
    → LoginViewModel.loginWithSocial()
    → LoginUseCase.execute()
    → AuthenticationCoordinator.authenticate()
    → SocialAuthStrategy.signIn()
    → AuthenticationResult
```

## Key Design Principles

### 1. Protocol-First Design
Every authentication method is defined by a protocol, allowing easy mocking for tests and swapping implementations.

### 2. Strategy Pattern
Different authentication methods are encapsulated as strategies, registered with the coordinator.

### 3. Single Responsibility
- **Strategies**: Handle authentication for specific method
- **Coordinator**: Routes to appropriate strategy
- **Use Cases**: Add business logic, validation
- **ViewModel**: Manages UI state and user actions

### 4. Dependency Injection
All dependencies are injected through initializers, no singletons.

### 5. Sendable & Concurrency
All types conform to `Sendable` and use `async/await` for thread-safety.

## Testing Strategy

### Unit Tests
- Test each strategy in isolation with mocks
- Test use cases with stub strategies
- Test view model with stub use cases

### Integration Tests
- Test coordinator with real strategies
- Test complete login flows

### Example Test
```swift
func test_whenLoginWithEmailPassword_shouldReturnAuthResult() async throws {
    // Arrange
    let mockUseCase = MockLoginUseCase()
    let viewModel = LoginViewModel(loginUseCase: mockUseCase)
    
    // Act
    await viewModel.loginWithEmailPassword(email: "test@example.com", password: "password")
    
    // Assert
    XCTAssertEqual(viewModel.flowState, .success)
}
```

## Benefits

✅ **Extensible**: Add new methods without changing existing code  
✅ **Testable**: Each component can be tested in isolation  
✅ **Maintainable**: Clear separation of concerns  
✅ **Flexible**: Easy to swap implementations  
✅ **Type-Safe**: Compile-time guarantees with protocols  

## Next Steps

1. Implement concrete strategies in Data layer
2. Create SwiftUI views for each login method
3. Implement navigation coordinator
4. Add unit tests for all use cases
5. Add integration tests for complete flows
6. Add analytics and logging
7. Add biometric authentication support

---

**Last Updated**: January 7, 2026
