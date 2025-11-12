# Firebase Collections Guide

## Overview
This guide explains how to work with Firebase Firestore collections in a scalable and maintainable way.

## Constants Structure

All Firebase collection names and document IDs are centralized in `FirebaseConstants.swift`:

```swift
struct FirebaseConstants {
    struct Collections {
        static let appMetadata = "AppMetadata"
        static let users = "Users"
        static let houses = "Houses"
        // ... more collections
    }
    
    struct Documents {
        static let currentAppMetadata = "current"
        // ... more document IDs
    }
}
```

## Usage Pattern

### ✅ Good - Using Constants
```swift
actor UserService: UserProviding {
    private let db = Firestore.firestore()
    
    func getUser(id: String) async throws -> User {
        let snapshot = try await db
            .collection(FirebaseConstants.Collections.users)
            .document(id)
            .getDocument()
        // ...
    }
}
```

### ❌ Bad - Hardcoded Strings
```swift
actor UserService: UserProviding {
    func getUser(id: String) async throws -> User {
        let snapshot = try await db
            .collection("Users")  // DON'T DO THIS
            .document(id)
            .getDocument()
        // ...
    }
}
```

## Adding New Collections

When adding a new feature that requires Firestore:

1. **Add collection name to `FirebaseConstants.Collections`**:
   ```swift
   struct Collections {
       // ... existing collections
       static let recipes = "Recipes"
   }
   ```

2. **Add document IDs if needed** (for singleton documents):
   ```swift
   struct Documents {
       // ... existing documents
       static let defaultRecipes = "defaults"
   }
   ```

3. **Use in your service**:
   ```swift
   actor RecipeService: RecipeProviding {
       private let db = Firestore.firestore()
       
       func getRecipes() async throws -> [Recipe] {
           let snapshot = try await db
               .collection(FirebaseConstants.Collections.recipes)
               .getDocuments()
           // ...
       }
   }
   ```

## Benefits

- **Single Source of Truth**: All collection names in one place
- **Refactoring Safety**: Change collection name once, updates everywhere
- **Type Safety**: Compile-time checks for typos
- **Discoverability**: Easy to see all available collections
- **Documentation**: Self-documenting structure

## Examples from Codebase

### App Metadata Service
```swift
let snapshot = try await db
    .collection(FirebaseConstants.Collections.appMetadata)
    .document(FirebaseConstants.Documents.currentAppMetadata)
    .getDocument()
```

### Future: House Service
```swift
let snapshot = try await db
    .collection(FirebaseConstants.Collections.houses)
    .document(houseId)
    .getDocument()
```

### Future: User Profile Service
```swift
let snapshot = try await db
    .collection(FirebaseConstants.Collections.profiles)
    .document(userId)
    .getDocument()
```

## Subcollections

For subcollections, extend the pattern:

```swift
struct Collections {
    static let houses = "Houses"
    
    struct House {
        static let members = "Members"
        static let items = "Items"
    }
}

// Usage:
db.collection(FirebaseConstants.Collections.houses)
  .document(houseId)
  .collection(FirebaseConstants.Collections.House.items)
  .getDocuments()
```

## Testing

Mock services should use the same constants:

```swift
struct MockUserService: UserProviding {
    func getUser(id: String) async throws -> User {
        // Mock implementation
        // Still references FirebaseConstants for consistency
    }
}
```
