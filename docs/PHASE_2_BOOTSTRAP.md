# Phase 2: Flutter Bootstrap

Status: GitHub Actions bootstrap succeeded on 2026-10-09 (run #3). The Android scaffold, `.metadata`, and `pubspec.lock` are committed on `phase-2/flutter-bootstrap`. This confirms SDK setup and dependency resolution only, not analyzer/test/build readiness.

## Toolchain decision
- Flutter SDK: **3.47.5 stable**, pinned in `.fvmrc`.
- Dart SDK: use the Dart version bundled with that exact Flutter SDK. The official Flutter archive lists Flutter 3.47.5 with Dart 3.13.4 for Linux x64.
- Do not install a separate, independently versioned Dart SDK for this Flutter project.
- Official reference: https://docs.flutter.dev/install/archive

## Added
- Flutter package manifest with Riverpod, GoRouter, Drift, offline PDF and local-path dependencies.
- Strict Dart analysis configuration.
- Minimal ProviderScope entry point and application shell.
- Locked base palette tokens: navy #17324D, teal #0F766E, canvas #F5F7FA.
- Ignore rules for local data, build artifacts and signing secrets.
- `.fvmrc` toolchain pin and a GitHub Actions bootstrap workflow.

## Bootstrap workflow scope
The workflow is intended to:
1. Install the pinned Flutter SDK on a GitHub-hosted Linux runner.
2. Generate the standard Android platform scaffold in a temporary project using Flutter tooling.
3. Copy the generated Android scaffold and Flutter metadata into this branch.
4. run `flutter pub get` to resolve dependencies and produce the real `pubspec.lock`.
5. commit only generated Android scaffold/metadata and the lockfile back to this work branch.

It deliberately does **not** run `flutter analyze`, tests, `flutter build`, Gradle build tasks, or produce an APK. Workflow execution is asynchronous; do not treat the setup as complete until its run and resulting commit are checked.

## Deliberately not claimed
- No Flutter command has been run in the assistant container; `flutter` and `dart` are absent there.
- GitHub Actions run #3 succeeded and the generated Android scaffold, `.metadata`, and `pubspec.lock` were fetched from the branch for existence/content verification.
- No analysis, tests, build, APK or device verification has been run.
- No database schema, migration or business workflow is implemented.

## Completion gates
1. Bootstrap workflow passed: https://github.com/Rohitkarma62/EduManage/actions/runs/37956415531
2. Generated Android files, `.metadata`, and `pubspec.lock` were verified present on the work branch; `flutter pub get` succeeded.
3. Remaining gate: explicit authorization is required before formatting, static analysis, tests, Gradle tasks, or any build. None of those have been run.
4. Phase 2 must not be marked fully verified/build-ready until the authorized verification gate is completed and its results reviewed.
5. Only then start the Drift database foundation: schema versioning, tables, DAOs, migrations and migration/invariant tests.

Never report this branch as buildable until analysis/build evidence exists.
