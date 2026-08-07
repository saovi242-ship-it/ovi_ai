---
name: Flutter SDK compatibility
description: OVI AI currently uses Flutter 3.32 with Dart 3.8; code-generation packages must be selected for that SDK.
---

OVI AI's environment provides Flutter 3.32.0 with Dart 3.8.0. Flutter's SDK pins `intl` to 0.20.x, and the initial Hive, Drift, Riverpod, and JSON generator combination had incompatible analyzer/source_gen constraints. Keep code generators out until feature models are introduced, then add a Dart-3.8-compatible set together.

**Why:** Dependency resolution failed repeatedly when the scaffold included generator packages from incompatible release lines, even though the runtime packages were compatible.

**How to apply:** Prefer runtime dependencies first. When adding generated models, choose and test Hive/Drift/Riverpod/JSON generators as one compatibility set against the installed Dart SDK.