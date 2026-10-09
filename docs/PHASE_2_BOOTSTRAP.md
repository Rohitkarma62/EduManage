# Phase 2: Flutter Bootstrap and Static Verification

**Status:** Bootstrap, static analysis, and the current widget smoke test passed in GitHub Actions on 2026-10-09. This is a verified bootstrap checkpoint, not a claim that the complete app is implemented or production-ready.

## Toolchain decision
- Flutter SDK: **3.47.5 stable**, pinned in `.fvmrc` and the workflow.
- Dart SDK: use the Dart version bundled with that exact Flutter SDK. The Flutter archive lists Flutter 3.47.5 with Dart 3.13.4 for Linux x64.
- Do not install a separate, independently versioned Dart SDK for this Flutter project.
- Official reference: https://docs.flutter.dev/install/archive

## Added
- Flutter package manifest with Riverpod, GoRouter, Drift, offline PDF and local-path dependencies.
- Strict Dart analysis configuration.
- Minimal ProviderScope entry point and application shell using the locked base palette: navy #17324D, teal #0F766E, canvas #F5F7FA.
- Ignore rules for local data, build artifacts and signing secrets.
- `.fvmrc` toolchain pin, generated Android scaffold, Flutter metadata, resolved `pubspec.lock`, GitHub Actions workflow and one bootstrap widget smoke test.

## CI verification
The workflow on `phase-2/flutter-bootstrap` performs:
1. Install the pinned Flutter SDK on a GitHub-hosted Linux runner.
2. Generate the standard Android platform scaffold in a temporary project using Flutter tooling.
3. Copy the generated Android scaffold and Flutter metadata into this branch.
4. Run `flutter pub get`.
5. Run `flutter analyze`.
6. Run `flutter test`.
7. Commit generated Android scaffold/metadata and the lockfile back to the work branch if they changed.

Verified run: https://github.com/Rohitkarma62/EduManage/actions/runs/37958071222

Run #7 completed successfully. The dependency resolution, analyzer, widget smoke test, and generated-file commit steps all reported success. Earlier run #6 only covered the bootstrap/dependency steps and is not the evidence for analyzer/tests.

## Deliberately not claimed
- No Flutter command was run in the assistant container; Flutter and Dart are not installed there. Verification ran in GitHub Actions.
- No `flutter build`, Gradle task, APK generation, release signing, emulator test, or physical-device test has been run.
- Passing the current analyzer and one smoke test does not prove that the full product is bug-free or release-ready.
- The UI is only a bootstrap shell. No production screens, Drift database schema/migrations, DAOs, financial or attendance workflows, backup/restore, licensing, or PDF business workflows are implemented yet.
- Android application ID is still the generated placeholder `com.example.edumanage_offline`; release signing is still the generated debug-signing scaffold. These must be addressed before any release build.

## Phase 2 checkpoint
1. [x] Flutter toolchain pinned and Android platform scaffold generated.
2. [x] Dependencies resolved and `pubspec.lock` committed.
3. [x] `flutter analyze` passed in GitHub Actions.
4. [x] Current widget smoke test passed in GitHub Actions.
5. [ ] Final repository/documentation consistency review and explicit readiness decision.

Do not start Phase 3 until Phase 2 is explicitly closed. Do not call this release/build-ready based on the current checks alone. No APK or Gradle build is authorized by this checkpoint.
