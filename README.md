# SpaceMix Flutter App

SpaceMix is a modern, premium music application built with Flutter. It follows Clean Architecture principles, uses Bloc-Cubit for state management, and incorporates a "Cosmic Editorial" design system.

## Project Architecture

This project strictly adheres to **Clean Architecture** and a **Feature-First** structure:

*   **`lib/core/`**: Contains core functionalities applicable app-wide.
    *   `app_constants.dart`: Global static values.
    *   `app_theme.dart`: Centralized Cosmic Editorial theme controls.
    *   `database/database_helper.dart`: SQLite Local Database setup.
    *   `routing/app_router.dart`: AutoRoute generator configurations.
    *   `models/`: JSON serialization models (`TrackModel`, `UserProfileModel`, etc.).
*   **`lib/features/`**: Contains feature-specific code. Each feature is broken down into `presentation`, `domain`, and `data` layers when necessary. Current scaffolding includes basic routing.
*   **`assets/data/`**: JSON Dummy Data representing the main content, search content, user profiles, and favorites.

## Design System

The application uses the **Cosmic Editorial** design system controlled globally via `MaterialApp` in `lib/main.dart` and `AppTheme`.
*   **Typography:** Space Grotesk (Headlines), Manrope (Body)
*   **Colors:** Deep Space Voids (`#0e0e13`) with Neon Precision (`#a68cff`, `#b5ffc2`).

## Execution & Code Generation

### 1. Install Dependencies
Run the following command to make sure all dependencies are localized:
```bash
flutter pub get
```

### 2. Generate Code (Models & Routing)
SpaceMix uses `json_serializable` and `auto_route` which require code generation. Always run this command after making changes to models or routing:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Run the App
Launch the app via standard Flutter commands:
```bash
flutter run
```
