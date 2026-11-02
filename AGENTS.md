# SpaceMix – AI Agent Guide

## Architecture Overview

SpaceMix is a Flutter music app following **Clean Architecture** with a **Feature-First** layout.

```
lib/
  core/           # App-wide: theme, constants, routing, models, DI, DB
  features/       # One folder per feature (home, player, finder, library, playlist, profile, downloads, splash)
    <feature>/
      data/       # Repository implementations, data sources
      domain/     # Abstract repository interfaces
      presentation/
        cubit/    # Cubit + State files (flutter_bloc)
        pages/    # Screen widgets
assets/data/      # JSON mock data (main_content.json, search_content.json, etc.)
```

## Dependency Injection

All singletons are registered in `lib/core/services/service_locator.dart` via **GetIt** (`sl`).  
Access registered instances with `sl<T>()`. Cubits are NOT registered in the locator; they are provided directly via `BlocProvider` in the widget tree, receiving their repository from `sl`.

## State Management Pattern

Every feature uses **Cubit** (not full Bloc). The pattern is:
1. `<feature>_state.dart` – sealed/abstract state classes (`Initial`, `Loading`, `Loaded`, `Error`)
2. `<feature>_cubit.dart` – Cubit that receives the domain repository and emits states

Example: `HomeCubit(HomeRepository) → emit(HomeLoading) → emit(HomeLoaded(tracks))`

## Routing

Navigation uses **auto_route**. All routes are declared in `lib/core/routing/app_router.dart`.  
The generated file is `app_router.gr.dart` (do not edit manually).  
Each page widget must be annotated with `@RoutePage()`.  
Re-run code generation after adding/modifying routes or models (see below).

## Code Generation (Required Workflow)

Two generators are in use: `json_serializable` (models) and `auto_route_generator` (routing).

```bash
# After changing any model or route definition:
flutter pub run build_runner build --delete-conflicting-outputs
```

Model files ending in `.g.dart` and `app_router.gr.dart` are generated — never edit them manually.

## Data / Models

JSON models live in `lib/core/models/` and are annotated with `@JsonSerializable()`.  
Mock data is loaded from `assets/data/*.json` at runtime (no network calls currently).  
`DatabaseHelper` (`lib/core/database/database_helper.dart`) wraps **sqflite** for local persistence (used by `LibraryRepository`).

## Design System – Cosmic Editorial

- **Theme:** defined in `lib/core/app_theme.dart`, applied globally in `main.dart`
- **Colors:** background `#0e0e13`, primary accent `#a68cff`, secondary `#b5ffc2`
- **Fonts:** Space Grotesk (headlines) · Manrope (body) — loaded via `google_fonts`
- **Constants:** reusable values in `lib/core/app_constants.dart`

## Key Commands

```bash
flutter pub get                                                   # install deps
flutter pub run build_runner build --delete-conflicting-outputs  # codegen
flutter run                                                       # run app
flutter analyze                                                   # lint
```

## Adding a New Feature

1. Create `lib/features/<name>/{data,domain,presentation/{cubit,pages}}/`
2. Define abstract repository in `domain/repositories/`
3. Implement it in `data/repositories/`
4. Register the singleton in `service_locator.dart`
5. Add `@RoutePage()` page, register route in `app_router.dart`
6. Run `build_runner` to regenerate `app_router.gr.dart`

