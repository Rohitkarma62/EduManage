# EduManage Offline

**Offline-first coaching institute and small-school management app for Android.**

EduManage is being developed with Flutter/Dart and a local SQLite database (Drift). The intended product keeps core records on-device, supports offline workflows and PDF documents, and uses signed offline license files for Basic, Professional and Premium feature tiers.

> **Development status:** The repository is currently a foundation-stage project. The database foundation (student records, classes, batches, effective-dated student assignments and migration/integrity tests) has passed its latest recorded GitHub Actions verification. The complete product is **not yet implemented or release-ready**. Do not treat this README as a claim that all listed product capabilities are already available.

## Current implementation

- Flutter bootstrap and app shell.
- Pinned Flutter toolchain and dependency lockfile.
- Drift/SQLite database foundation with schema version 4.
- Student DAO: create, lookup, active-list pagination, contact updates and soft deactivation.
- Student assignment DAO with date-range validation and overlap prevention.
- SQLite integrity triggers for assignment overlap, class/batch consistency, assignment scope keys and valid date ranges.
- Migration tests for v1-to-v4 upgrades, legacy-data preservation and rollback when upgrades fail.
- GitHub Actions checks for Drift code generation, Dart/Flutter analysis and tests.

## Planned product capabilities

These are product requirements and roadmap items, **not claims of current implementation**:

- Student and staff management.
- Fees, payments, receipts, refunds, expenses and salary records.
- Attendance, classes and batches, exams, results and certificates.
- Offline PDF generation and locally managed documents.
- Backup and restore with integrity checks and recovery protection.
- Signed, non-expiring offline license files for Basic, Professional and Premium tiers.
- Tier downgrades that preserve existing data and never silently delete records.

## Technology

- Flutter / Dart
- Drift with SQLite for local persistence
- Riverpod for state management
- GoRouter for navigation
- Local PDF and file workflows
- GitHub Actions for automated verification

No cloud backend is required for the intended core offline workflows.

## Repository verification

- Phase 2 bootstrap notes: [docs/PHASE_2_BOOTSTRAP.md](docs/PHASE_2_BOOTSTRAP.md)
- Phase 3 database audit: [docs/PHASE_3_DATABASE_FOUNDATION.md](docs/PHASE_3_DATABASE_FOUNDATION.md)
- Specification reconciliation and open blockers: [docs/RECONCILIATION.md](docs/RECONCILIATION.md)
- Decision log: [docs/decision_log.md](docs/decision_log.md)

Latest recorded successful workflow: [GitHub Actions Run #50](https://github.com/Rohitkarma62/EduManage/actions/runs/38107462863). It ran pinned Flutter setup, dependency resolution, Drift code generation, `flutter analyze`, `flutter test` and the generated-files step. The subsequent documentation-only change needs its own CI run before it can be described as independently verified.

## Important release limitations

- The PR for Phase 3 remains a draft and has not been merged.
- The Android application ID is still the generated placeholder `com.example.edumanage_offline`.
- Release signing is not configured; the generated Android scaffold uses debug signing for release builds.
- Finance, attendance, exams/results, certificates, backup/restore, licensing and the complete screen set still require implementation and tests.
- Product decisions P-01 through P-07 remain pending. They must not be silently guessed or treated as approved.
- No APK, Gradle release build, emulator test or physical-device test is claimed by the current verification.

## Development rule

Do not mark a feature complete until its implementation, tests, relevant migration/restore compatibility and CI evidence are present. Do not put private signing keys, release keystores, real student/staff data, production backups or secrets in Git.
