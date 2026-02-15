# Create House Flow

This document explains how "Create House" works end to end in the current architecture.

## Goal

Keep UI simple and move business decisions into dedicated modules/use cases:

- Presentation layer triggers actions and renders state.
- `HouseModule` owns house creation + sync-state transitions.
- Profile sync module owns profile update + sync-state transitions.

## Entry Point (UI)

1. User taps **Create House** in `HouseSelectionScreen`.
2. `HouseSelectionViewModel.createHouse(...)` is called.
3. ViewModel delegates to `CreateHouseUseCase`.

Relevant files:

- `keepitfresh/Presentation/Household/HouseSelectionScreen.swift`
- `keepitfresh/Presentation/Household/HouseSelectionViewModel.swift`
- `keepitfresh/Domain/UseCases/House/CreateHouseUseCase.swift`

## Orchestration Use Case

`CreateHouseUseCase` coordinates the full flow:

1. Load authenticated user.
2. Load current profile.
3. Build house create request.
4. Ask `HouseModule` to create the house.
5. Ask profile sync module to append the new house ID to profile.
6. Return updated `profile + house` to the ViewModel.

## House Module Flow (Create)

Implemented in `HouseholdRepository.createHousehold(...)`:

1. Validate name.
2. Create local placeholder record with `syncState = .pending`.
3. Save pending record in local storage (`HouseStorageServicing`).
4. Call remote service (`HouseNetworkServicing.createHousehold`).
5. On success:
   - mark record as `syncState = .synced`
   - upsert synced record to local storage
   - return synced household
6. On failure:
   - mark local record as `syncState = .failed`
   - persist failed state
   - throw error

Current storage implementation is mock/in-memory:

- `keepitfresh/Data/HouseModule/InMemoryHouseStorageService.swift`

Current network adapter:

- `keepitfresh/Data/HouseModule/HouseNetworkServiceAdapter.swift`

## Profile Sync Flow (Append House ID)

Implemented in `UpdateProfileHouseholdsUseCase` + `ProfileSyncRepository`:

1. Build updated profile with appended `householdId`.
2. Save local profile sync record as `.pending`.
3. Trigger remote profile update.
4. On success:
   - save local profile sync record as `.synced`
   - return updated profile
5. On failure:
   - save local profile sync record as `.failed`
   - throw error

Current storage implementation is mock/in-memory:

- `keepitfresh/Data/ProfileSync/InMemoryProfileStorageService.swift`

Current remote adapter:

- `keepitfresh/Data/ProfileSync/ProfileRemoteServiceAdapter.swift`

## In-Memory UI Update

After successful orchestration:

- ViewModel updates `profile`
- ViewModel appends/sorts returned `house`
- UI refreshes with latest state

If any step throws:

- ViewModel sets `errorMessage`
- UI shows native error alert

## Data Contracts

House module uses a base, codable model:

- `Household` (module model)
- `CreateHouseholdRequest` (input contract)
- `HouseSyncState` (`pending/synced/failed`)

App model mapping:

- `House(moduleHousehold:)` in `keepitfresh/Domain/Models/House/House+HouseModuleMapping.swift`

## Notes for Future DB Migration

When moving from mock DB to CoreData/SwiftData/Realm:

1. Replace only:
   - `InMemoryHouseStorageService`
   - `InMemoryProfileStorageService`
2. Keep use cases/repositories unchanged.
3. Preserve sync-state semantics (`pending -> synced/failed`) so retry/recovery behavior remains consistent.
