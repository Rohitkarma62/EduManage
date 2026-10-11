# EduManage Offline — Reconciliation and Remaining Work

- Repository: `Rohitkarma62/EduManage`
- Current working branch: `phase-3/database-foundation`
- Related pull requests: [Phase 2 bootstrap #1](https://github.com/Rohitkarma62/EduManage/pull/1), [Phase 3 database foundation #2](https://github.com/Rohitkarma62/EduManage/pull/2)
- Scope: compare current tracked implementation with the intended offline-first product requirements.
- Build policy: no APK or Gradle build was run as part of this review.
- Merge policy: neither pull request is merged by this work.

## Executive summary

The repository is no longer just an empty scaffold: it contains a Flutter bootstrap, a generated Android platform scaffold, a dependency lockfile, an app shell, and a tested Drift/SQLite database foundation for institute settings, students, classes, batches and effective-dated student assignments.

It is still **not a complete school/coaching management product and is not release-ready**. The implemented screen is a bootstrap shell. Most feature folders remain placeholders. The current green CI covers dependency resolution, Drift code generation, static analysis and automated tests, not a release APK or physical-device behavior.

## Verified implementation

- Flutter toolchain pinned to 3.47.5 stable; Dart is supplied by that Flutter SDK.
- Riverpod, GoRouter, Drift, local file/PDF dependencies and `pubspec.lock` are present.
- Flutter app shell uses the locked palette tokens.
- SQLite is stored in app-private application-support storage; foreign keys and WAL are enabled.
- Drift schema v4 includes institute settings, students, class groups, batches and student assignments.
- Student DAO supports create, lookup, active-list pagination, contact update and soft deactivation.
- Assignment DAO validates references, positive effective intervals and overlap; SQLite triggers protect core integrity even for direct SQL writes.
- Migration tests exercise v1-to-v4 migration, preservation of seeded data, integrity-trigger installation and rollback when v1, v2 or v3 upgrades fail.
- Latest recorded successful workflow: [Run #50](https://github.com/Rohitkarma62/EduManage/actions/runs/38107462863). It completed pinned Flutter setup, dependency resolution, Drift generation, `flutter analyze`, `flutter test` and the generated-file step.
- Documentation changes made after Run #50 are not independently verified until a workflow runs against the newer commit.

## Open product decisions — preserve P-01 through P-07

Do not infer business decisions from code or freeze production schema until the relevant decisions are approved and backed by evidence.

- **P-01:** opening-balance provenance and ambiguous legacy balance handling.
- **P-02:** refund lifecycle/cancellation stages.
- **P-03:** exact PDF-byte retention by document type.
- **P-04:** salary accounting correction versus actual cash recovery.
- **P-05:** published-result correction and certificate review/reissue.
- **P-06:** restore journal and audit survival architecture.
- **P-07:** operation-level license entitlement matrix.

Details and required evidence are in [decision_log.md](decision_log.md). Existing SC-01–SC-10, CC-01–CC-16 and B-01–B-20 identifiers and meanings must be preserved; unresolved requirements must not be marked complete without source/test evidence or authorized approval.

## Remaining implementation work

### Product modules
- Student/class/batch UI and repository integration beyond the current database DAO slice.
- Staff and staff assignment workflows.
- Fee plans/ledger, opening balances, payments, receipt numbering, partial payments, oldest-outstanding allocation, credits/discounts, refunds/reversals and expense/salary accounting.
- Attendance with explicit Unmarked state, atomic saves, duplicate prevention and audited corrections.
- Exams, draft mark states, immutable/versioned published results and linked certificates.
- Offline PDF generation with approved snapshots, retention and reissue rules.
- Managed-file ownership, integrity and retention.
- Backup/restore with consistent SQLite/WAL snapshot, manifest/checksums, staging, validation, safety backup, durable recovery journal and rollback.
- Signed offline licensing, invalid-import safety, non-expiring license handling, operation-level entitlements and downgrade-safe read-only behavior.
- The agreed screen set and navigation. The product target has 45 active screens; SCR-19 is retired and merged into SCR-42.

### Engineering/release work
- Review the full Phase 2 base/integration state and reconcile PR #1's stale description with actual CI evidence.
- Add canonical schema export and migration evidence before the next schema-version change; this is not a claim that the current schema is production-frozen.
- Run CI after the newest documentation/workflow changes and record the exact tested commit.
- Review generated placeholder Android application ID `com.example.edumanage_offline`; do not guess a final application ID without an approved product identity.
- Configure release signing through protected secrets/keystore handling; never commit private signing keys or passwords.
- Add unit, database, migration, workflow, PDF, backup/restore, licensing, and UI tests for each implemented module.
- Perform offline-device and restore interruption tests before release.
- Run the final APK/release build only when the build phase is authorized.

## Data-safety and architecture constraints

- All core workflows must work offline and store operational data locally.
- Money must be stored as integer paise.
- Invalid license import must not replace a valid license or damage data.
- Downgrade must preserve data; gated features may become read-only.
- Student assignments use half-open effective intervals `[effective_from, effective_to)`; adjacent intervals are allowed, overlapping intervals are not.
- Leave is excluded from the attendance denominator; Present / (Present + Absent) is used, with explicit states for zero denominator and missing records.
- Published results and historical financial corrections require audit/version history.
- Restore must be recoverable across process termination and must not depend on the database being replaced to retain its own recovery journal.
- The locked visual design must not be changed without explicit authorization.

## Final disposition

- **Database foundation:** PASS for the implemented Phase 3 scope on the last verified code commit.
- **Complete product:** NOT COMPLETE.
- **P-01–P-07:** PENDING authorized product/business decisions.
- **Release readiness:** NOT CLEARED.
- **PRs:** keep both open/draft until current CI evidence, integration review and phase-specific acceptance criteria are satisfied. Do not merge merely because one CI run is green.
