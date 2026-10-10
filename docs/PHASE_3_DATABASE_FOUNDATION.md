# Phase 3: Database Foundation

**Status:** Initial database foundation implemented. The last confirmed successful CI run generated Drift code, reported no analyzer issues, and passed 7 tests at an earlier commit. A follow-up test commit now adds direct foreign-key and invalid-interval checks; a fresh CI run is required before claiming those new checks pass. This is not product-complete or release-ready.

## Scope of this first slice

- Local SQLite database opened from app-private application-support storage.
- Drift schema version 1.
- Institute settings, students, class groups, batches, and effective-dated student assignments.
- Foreign-key enforcement and WAL mode configured for the app database connection.
- Basic local student create/list/find/update-contact/deactivate operations.
- Student DAO tests for local create/read, blank-name rejection, and soft deactivation.
- Assignment tests for adjacent half-open intervals, overlap rejection, batch/class mismatch, direct foreign-key rejection, and non-positive interval rejection.
- No network dependency and no cloud storage.

## Verification record

- Drift generated part file `lib/core/database/app_database.g.dart` is committed.
- Previous successful CI run: Drift code generation succeeded, `flutter analyze` reported no issues, and all 7 tests passed.
- Workflow command is `dart run build_runner build`; it does not use the removed `--delete-conflicting-outputs` option.
- New integrity tests are committed and await fresh CI verification.
- No Gradle task, Flutter APK build, or device-level test has been run.

## Initial schema decisions

- Student deactivation is a soft state change; historical assignments should not be erased as a side effect.
- Class and batch names are unique within their intended scope.
- Student assignment intervals are half-open: `[effective_from, effective_to)`; a null end means currently open-ended.
- `assignment_scope_key` is non-null to avoid relying on SQLite's ambiguous NULL behavior for scoped uniqueness.
- Assignment creation validates class/batch consistency and rejects overlapping intervals in a transaction.
- Money, fee ledgers, opening balances, payments, refunds, salary, discounts/credits, exams, results, certificates, backups and licensing are intentionally not part of schema v1. They require their approved invariants and unresolved decisions P-01 through P-07 where applicable.

## Required next implementation gates

1. Obtain a fresh successful CI run against the latest Phase 3 commit.
2. Add tests proving duplicate class names and duplicate batch names within the same class are rejected by SQLite; also test allowed same-named batches across different classes if that is the intended product rule.
3. Add schema snapshot/export and a documented migration test strategy before introducing schema version 2.
4. Review whether the database itself should enforce batch/class consistency and non-overlapping assignment intervals, rather than relying solely on DAO validation.
5. Review the first schema against the approved product specification before adding financial tables. Do not invent opening-balance or refund semantics to fill schema gaps.

## Important limitations

- Schema version 1 is the first development schema, not a promise of production migration compatibility. Once user data exists, schema changes require migration tests and backup/restore compatibility review.
- CI tests use an in-memory SQLite database. Device-level behavior and restore/migration behavior have not been verified.
- Phase 2/Phase 3 branch history was synchronized before this review. PR #2 remains draft and must not be merged until the verification and review gates pass.
