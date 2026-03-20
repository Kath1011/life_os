# LifeOS

LifeOS is an Android-first Flutter app designed as a practical, offline-capable life operations companion. The product style is a field-manual interface focused on clear emergency access, fast diagnostics, and local-first utility workflows.

## Product Direction (Mapped to Your Functional Requirements)

- FR1 (Offline navigation and emergency access): a persistent emergency action path with high-contrast guidance and no internet dependency.
- FR2 (Diagnostic flowcharts and decision logic): binary branching and safety locks that prevent risky actions until user acknowledgement.
- FR3 (Inventory matching and utility tools): pantry matcher, templates, and local home profile data.
- FR4 (Routine scheduling and preventive maintenance): recurring cards, progress states, and local notifications.

## Project Structure (Simple and Scalable)

The codebase is now organized under `lib` with these top-level folders:

- `lib/core`: app shell, theme, shared configuration.
- `lib/features`: feature-first UI and logic (dashboard, diagnostics, pantry, schedules).
- `lib/widgets`: reusable presentational widgets.
- `lib/services`: cross-feature state and services.

Current implementation entrypoints:

- `lib/main.dart`: wraps the app in Riverpod `ProviderScope`.
- `lib/core/app/lifeos_app.dart`: Material app and global theme.
- `lib/features/dashboard/presentation/lifeos_shell.dart`: multi-tab LifeOS shell.
- `lib/services/lifeos_controller.dart`: central Riverpod controller/state.

## Riverpod Introduction for LifeOS

Riverpod is now the state management foundation because it fits your product constraints:

- Predictable state for complex safety logic (especially FR2 gating and emergency flows).
- Testable business logic outside widgets.
- Clear separation of UI (`features`, `widgets`) from state mutations (`services`).
- Easy growth from simple local state to repositories and offline persistence.

### The Core Pattern Used Here

1. `LifeOsState` is immutable and contains app-level values:
	- current tab
	- emergency mode status
	- diagnostic safety acknowledgement
	- pantry ingredient selections
2. `LifeOsController` (a Riverpod `Notifier`) is the only write-path:
	- `switchTab(...)`
	- `toggleEmergencyMode()`
	- `setSafetyAcknowledged(...)`
	- `toggleIngredient(...)`
3. UI watches state and dispatches actions:
	- `ref.watch(lifeOsControllerProvider)` to rebuild on state changes
	- `ref.read(lifeOsControllerProvider.notifier)` to invoke actions

This gives you a clean mental model: widgets render state, controller changes state.

## Android-Only Development Workflow

You are focusing on Android, so this is the working loop:

1. `flutter pub get`
2. `flutter run -d android`
3. During coding, use hot reload for UI/state iteration.
4. Validate often:
	- `flutter analyze`
	- `flutter test`

You can keep other platform folders in the repo, but day-to-day development and release can stay Android-only.

## Current Feature Mapping

1. FR1 emergency access: `lib/features/emergency` and `lib/features/home`.
2. FR2 diagnostics logic: `lib/features/diagnostics`.
3. FR3 inventory and utility tools: `lib/features/utilities`.
4. FR4 routine scheduling: `lib/features/schedules`.

## Next Build Steps

1. Add local persistence (Hive/Isar/shared_preferences) behind service abstractions.
2. Split `LifeOsController` into per-feature controllers once logic grows.
3. Add widget and provider tests for emergency and safety-critical paths.
