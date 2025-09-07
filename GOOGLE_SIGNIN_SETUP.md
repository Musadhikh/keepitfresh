# Google Sign-In Configuration

## Overview
The project has been configured for Google Sign-In integration with Firebase Authentication. This document outlines the setup and usage.

## Configuration Files

### 1. GoogleSignInConfig.swift
- Centralizes Google Sign-In configuration
- Reads CLIENT_ID from GoogleService-Info.plist
- Handles URL callbacks for the sign-in flow

### 2. GoogleSignInHelper.swift
- Provides main actor methods for sign-in operations
- Handles UI presentation and error mapping
- Includes debug mock functionality for testing

### 3. GoogleAuthService.swift (Data Layer)
- Implements GoogleAuthProviding protocol
- Actor-based for thread safety
- Integrates with the authentication system

## Integration Points

### App Level (KeepItFreshApp.swift)
```swift
// Firebase and Google Sign-In configuration in init()
FirebaseApp.configure()
GoogleSignInConfig.configure()

// URL handling for sign-in callbacks
.onOpenURL { url in
    _ = GoogleSignInConfig.handleURL(url)
}
```

### Domain Layer
- `GoogleAuthProviding` protocol defines the interface
- `AuthCredential.google(idToken:accessToken:)` enum case
- `AuthError` enum for error handling

### Data Layer
- `GoogleAuthService` actor implements the protocol
- `AuthCredential+Extension` converts to Firebase credentials
- `FirebaseAuthService` uses converted credentials

## Dependencies
- GoogleSignIn-iOS (9.0.0) - Added via Swift Package Manager
- Firebase SDK integration
- UIKit for view controller presentation

## Security
- GoogleService-Info.plist is excluded from version control
- CLIENT_ID is read at runtime from the plist file
- URL schemes are configured in Info.plist for callback handling

## Usage
Once implementation is added, ViewModels can use:
```swift
let credential = try await GoogleSignInHelper.signIn()
let user = try await authService.signInWith(provider: googleAuthProvider)
```

## Testing
- Mock implementations available in debug builds
- `GoogleSignInHelper.mockSignIn()` for preview data
- Protocol-based design enables easy testing

## Next Steps
1. Add actual login UI implementation
2. Integrate with authentication ViewModels
3. Add proper error handling in UI
4. Test the complete authentication flow
