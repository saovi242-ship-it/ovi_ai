# OVI AI

Production-ready Flutter project foundation for a premium AI companion app.

This scaffold intentionally contains **no screens and no feature implementation**.
It establishes the boundaries and dependencies needed to build the product
incrementally without coupling UI, business rules, persistence, or networking.

## Project layout

```text
ovi_ai/
├── assets/
│   ├── animations/          # Lottie JSON animation files
│   ├── icons/               # Product icons and SVG/PNG icon assets
│   ├── images/              # Raster images and illustrations
│   ├── rive/                # Rive .riv interactive animation files
│   └── translations/        # easy_localization JSON translation files
├── integration_test/        # End-to-end tests on Android, Windows, and Web
├── lib/
│   ├── app/
│   │   ├── config/          # Environment and app-level configuration
│   │   ├── localization/   # Localization initialization and locale policy
│   │   ├── router/          # GoRouter configuration and route guards
│   │   └── theme/           # Material 3 color schemes, typography, and theme
│   ├── core/
│   │   ├── constants/       # Cross-feature constants and asset keys
│   │   ├── errors/          # Shared failures, exceptions, and error mapping
│   │   ├── network/         # Dio client, interceptors, and API policies
│   │   ├── responsive/      # Breakpoints and adaptive layout helpers
│   │   ├── storage/
│   │   │   ├── hive/        # Lightweight preferences, cache, and key-value data
│   │   │   └── sqlite/      # Drift database, tables, DAOs, and migrations
│   │   ├── utils/           # Small cross-feature utilities
│   │   └── widgets/         # Reusable primitives with no feature knowledge
│   ├── features/            # Product capabilities, each isolated by feature
│   │   └── feature_template/
│   │       ├── data/
│   │       │   ├── datasources/  # Remote and local data access
│   │       │   ├── models/       # DTOs and persistence models
│   │       │   └── repositories/ # Implementations of domain contracts
│   │       ├── domain/
│   │       │   ├── entities/     # Framework-independent business objects
│   │       │   ├── repositories/ # Abstract repository contracts
│   │       │   └── usecases/     # One business action per use case
│   │       └── presentation/
│   │           ├── controllers/  # Riverpod providers and feature state
│   │           ├── pages/        # Feature routes and screens, added later
│   │           └── widgets/      # Feature-specific UI components
│   ├── shared/
│   │   ├── models/          # Models intentionally shared by multiple features
│   │   ├── types/           # Shared typedefs and value types
│   │   └── widgets/         # Shared UI pieces that are not core primitives
│   └── main.dart            # Application entry point, added during app wiring
├── test/
│   ├── core/                # Unit tests for shared infrastructure
│   └── features/            # Unit and widget tests grouped by feature
├── android/                 # Android host project (generated with Flutter CLI)
├── web/                     # Web host project (generated with Flutter CLI)
└── windows/                 # Windows host project (generated with Flutter CLI)
```

## Architectural rules

- **Feature-first:** New product capability code belongs under
  `lib/features/<feature_name>`, not in a global UI or service folder.
- **Clean Architecture:** `presentation` depends on `domain`; `data` implements
  `domain` contracts. Domain code must not import Flutter, Dio, Hive, or Drift.
- **Riverpod:** Providers are the composition root for dependencies and feature
  state. Keep business decisions in use cases rather than widgets.
- **Dio:** The shared client belongs in `core/network`; feature data sources
  consume it through narrow interfaces.
- **Two storage layers:** Hive is for lightweight key-value state and caching;
  Drift provides typed, relational SQLite persistence and migrations.
- **Adaptive UI:** Android is the first target, while responsive decisions must
  use the shared breakpoint layer so Windows and Web do not require rewrites.
- **Material 3 dark foundation:** Theme tokens belong in `lib/app/theme`; feature
  code should consume theme values instead of hard-coding colors or text styles.

## Platform setup

The `android/`, `windows/`, and `web/` directories are intentionally represented
in the structure but are not populated with generated host files yet. From a
machine with the Flutter SDK installed, generate them with:

```bash
flutter create . --platforms=android,windows,web
flutter pub get
```

Then run code generation as needed:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Dependency overview

| Area | Packages | Purpose |
| --- | --- | --- |
| State | `flutter_riverpod`, `riverpod_generator` | Dependency injection and predictable feature state |
| Navigation | `go_router` | Declarative, deep-linkable navigation |
| Network | `dio` | Interceptors, retries, cancellation, and typed API clients |
| Key-value storage | `hive`, `hive_flutter` | Fast local preferences and cache |
| SQLite | `drift`, `drift_flutter`, `sqlite3_flutter_libs` | Typed relational storage with migrations |
| Animation | `lottie`, `rive` | JSON motion and interactive vector animation |
| Localization | `easy_localization`, `intl` | Translation loading, pluralization, and formatting |
| Responsive UI | `responsive_framework` | Shared adaptive breakpoints across form factors |
| Models | `json_annotation`, `json_serializable`, `freezed` | Immutable models and generated serialization |