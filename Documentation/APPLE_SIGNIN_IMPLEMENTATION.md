# Apple Sign-In Authentication Implementation

## Overview
This document describes the Apple Sign-In authentication implementation for KeepItFresh using Firebase Authentication.

## Architecture

### Components

#### 1. **AppleAuthStrategy** (`Data/Authentication/Strategies/AppleAuthStrategy.swift`)
- Implements `SocialAuthStrategyProviding` protocol
- Handles Apple Sign-In flow using `AuthenticationServices`
- Integrates with Firebase Authentication
- Manages nonce generation for security
- Implements ASAuthorizationControllerDelegate

#### 2. **AuthenticationCoordinator** (`Data/Authentication/Coordinator/AuthenticationCoordinator.swift`)
- Central coordinator for all authentication strategies
- Registers and manages multiple auth strategies
- Routes authentication requests to appropriate strategy
- Manages current user state via Firebase

#### 3. **AnonymousAuthStrategy** (`Data/Authentication/Strategies/AnonymousAuthStrategy.swift`)
- Implements anonymous/guest authentication
- Quick sign-in for users who want to try the app

## How It Works

### Apple Sign-In Flow

1. **User Taps "Sign in with Apple"**
   - `LoginView` calls `viewModel.loginWithSocial(provider: .apple)`

2. **ViewModel Routes Request**
   - `LoginViewModel` creates `LoginCredential.social(.apple)`
   - Calls `LoginUseCase.execute(with:)`

3. **Use Case to Coordinator**
   - `LoginUseCase` forwards to `AuthenticationCoordinator`
   - Coordinator finds `AppleAuthStrategy` for `.apple` provider

4. **Apple Sign-In Presentation**
   - `AppleAuthStrategy.signIn()` generates a secure nonce
   - Creates `ASAuthorizationAppleIDRequest` with nonce hash
   - Presents Apple Sign-In UI

5. **User Authenticates with Apple**
   - User completes Face ID/Touch ID/password authentication
   - Apple returns authorization with identity token

6. **Firebase Authentication**
   - Strategy extracts identity token from Apple credential
   - Creates Firebase `OAuthProvider.credential`
   - Signs in to Firebase with credential

7. **User Profile Update**
   - If new user, updates display name from Apple credential
   - Extracts email (if available)

8. **Result Creation**
   - Creates `AuthUser` with Firebase user data
   - Creates `AuthCredential.apple` for session management
   - Returns `AuthenticationResult` with user info

9. **Success Handling**
   - `LoginViewModel` receives result
   - Updates UI state to `.success`
   - `LoginCoordinator` handles navigation to main app

## Security Features

### Nonce Generation
- Uses `SecRandomCopyBytes` for cryptographically secure random nonce
- 32 characters using charset: `0-9A-Za-z-._`
- SHA-256 hash sent to Apple
- Original nonce used for Firebase verification

### Token Flow
```
User Auth → Apple ID Token → Firebase OAuthProvider → Firebase Auth Token
```

## Configuration

### 1. Entitlements
File: `keepitfresh.entitlements`
```xml
<key>com.apple.developer.applesignin</key>
<array>
    <string>Default</string>
</array>
```

### 2. Xcode Project Settings
- **Signing & Capabilities** tab
- Add "Sign in with Apple" capability
- Automatic signing or manual provisioning profile with Apple Sign-In enabled

### 3. Apple Developer Portal
1. Go to Certificates, Identifiers & Profiles
2. Select your App ID
3. Enable "Sign in with Apple"
4. Configure app identifiers and service IDs if needed

### 4. Firebase Console
1. Go to Authentication → Sign-in method
2. Enable "Apple" provider
3. Add your iOS Bundle ID
4. Configure OAuth redirect URI if needed

## Error Handling

### Apple Sign-In Errors
- **Canceled**: User tapped "Cancel" → `AuthError.cancelled`
- **Failed**: Authentication failed → `AuthError.authenticationFailed`
- **Invalid Response**: Invalid credential → `AuthError.invalidCredentials`
- **Unknown**: Other errors → `AuthError.unknown(error)`

### Firebase Errors
- Network issues → `AuthError.networkError`
- Account disabled → `AuthError.accountDisabled`
- Generic errors → `AuthError.unknown(error)`

## User Experience

### First-Time Sign-In
1. User sees Apple Sign-In button
2. Taps button → Apple ID prompt appears
3. User authenticates with Face ID/Touch ID/password
4. Chooses to share or hide email
5. App receives token and creates account
6. Display name automatically populated (if provided)
7. User is signed in and navigated to main screen

### Returning User
1. User taps Apple Sign-In
2. Automatic authentication (if previously authorized)
3. Instant sign-in
4. Navigated to main screen

### Email Privacy
- Users can choose "Hide My Email"
- Apple provides relay email: `[random]@privaterelay.appleid.com`
- App receives valid email for notifications

## Testing

### Simulator Testing
- Apple Sign-In works in iOS Simulator (iOS 13+)
- Can test with test Apple ID accounts
- No Face ID required in simulator

### TestFlight/Production
- Requires real device
- Real Apple ID credentials
- Face ID/Touch ID authentication

### Unit Testing
```swift
func test_appleSignIn_success() async throws {
    let strategy = AppleAuthStrategy()
    let result = try await strategy.signIn()
    
    XCTAssertNotNil(result.user)
    XCTAssertEqual(result.user.providers, [.apple])
}
```

## Data Stored

### AuthUser Model
```swift
AuthUser(
    id: "firebase-uid",           // Firebase UID
    email: "user@email.com",      // Email (if shared)
    displayName: "John Doe",      // Full name (if provided)
    photoURL: nil,                // No photo from Apple
    isEmailVerified: true,        // Auto-verified by Apple
    providers: [.apple]           // Provider type
)
```

### Firebase User Profile
- UID (unique identifier)
- Email (if shared)
- Display name (if provided)
- Email verified status
- Provider data (apple.com)

## Privacy Considerations

1. **Minimal Data Collection**: Only collect email/name if user shares
2. **Email Relay**: Support Apple's private email relay
3. **No Password Storage**: Apple handles authentication
4. **Revocation**: Users can revoke access in Apple ID settings
5. **GDPR Compliant**: Users control their data

## Troubleshooting

### "Sign in with Apple" button doesn't appear
- Check entitlements file has `com.apple.developer.applesignin`
- Verify capability added in Xcode
- Ensure provisioning profile has Apple Sign-In enabled
- Check App ID configuration in Developer Portal

### Authentication fails immediately
- Verify Firebase Apple provider is enabled
- Check bundle ID matches Firebase configuration
- Ensure device/simulator iOS version ≥ 13.0

### Email is nil
- User chose "Hide My Email"
- Use Apple's relay email from credential
- Prompt user to add email later if needed

### Token expired/invalid
- Nonce mismatch → regenerate and retry
- Token expired → user must re-authenticate
- Firebase configuration issue → check console settings

## Future Enhancements

1. **Token Refresh**: Implement automatic token refresh
2. **Credential Linking**: Link Apple Sign-In with email/password
3. **Account Migration**: Convert anonymous to Apple account
4. **Sign in with Apple JS**: Web support
5. **Multi-provider**: Allow multiple sign-in methods per account

---

**Last Updated**: January 7, 2026  
**iOS Version**: 13.0+  
**Firebase SDK**: Latest
