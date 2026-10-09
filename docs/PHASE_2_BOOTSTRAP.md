# Phase 2: Flutter Bootstrap

Status: initial source bootstrap committed on the work branch; not yet verified by Flutter tooling.

## Added
- Flutter package manifest with Riverpod, GoRouter, Drift, offline PDF and local-path dependencies.
- Strict Dart analysis configuration.
- Minimal ProviderScope entry point and application shell.
- Locked base palette tokens: navy #17324D, teal #0F766E, canvas #F5F7FA.
- Ignore rules for build artifacts, local databases, backups and signing secrets.

## Deliberately not claimed
- No `pubspec.lock` exists until dependency resolution is run with the selected Flutter/Dart SDK.
- No generated Android runner exists yet. Generate it using the pinned Flutter SDK with `flutter create --platforms=android .`; review generated files before committing.
- No analysis, tests, dependency resolution, build, APK or device verification has been run.
- No database schema, migration or business workflow has been implemented.

## Completion gates
1. Pin and record the actual Flutter and Dart SDK versions in the project toolchain policy.
2. Run Flutter project generation in a controlled Flutter environment and review the Android scaffold.
3. Run dependency resolution and commit the real generated lockfile.
4. Run formatting, static analysis and the starter test suite, recording exact commands and results.
5. Only then start the Drift database foundation: schema versioning, tables, DAOs, migrations and migration/invariant tests.

Do not report this branch as buildable until these gates have evidence.
