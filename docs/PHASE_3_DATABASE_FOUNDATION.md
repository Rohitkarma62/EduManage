# Phase 3: Database Foundation

**Status:** Initial local database foundation implemented; not product-complete or release-ready. Schema version 3 adds SQLite-level assignment integrity and derived-scope-key triggers. CI run #28 passed Drift code generation, Flutter analysis, and the full Flutter test suite for the foreign-key startup-guard regression test.

## Scope of this first slice

- Local SQLite database opened from app-private application-support storage.
- Drift schema version 3. Version 2 added assignment integrity triggers; version 3 added assignment scope-key integrity triggers.
- Institute settings, students, class groups, batches, and effective-dated student assignments.
- Foreign-key enforcement enabled before normal queries; `PRAGMA foreign_key_check` is checked when opening the database.
- Basic local student create/list/find/update-contact/deactivate operations.
- Student DAO tests for local create/read, blank-name rejection, and soft deactivation.
- Assignment tests for adjacent half-open intervals, overlap rejection, batch/class mismatch, direct foreign-key rejection, uniqueness scopes, and non-positive interval rejection.
- No network dependency and no cloud storage.

## Schema integrity rules

- Class names are unique; batch names are unique within a class. The same batch name may exist in different classes.
- Student assignment intervals are half-open: [effective_from, effective_to); a null end means currently open-ended.
- DAO validation rejects overlapping intervals and a batch/class mismatch before writing.
- SQLite triggers also reject overlapping assignments and batch/class mismatches for direct SQL writes, so bypassing the DAO does not bypass these invariants.
- Assignment scope keys are derived values: `class:<class_id>` when there is no batch, otherwise `batch:<batch_id>`. SQLite triggers reject mismatched scope keys on direct inserts and updates.
- Foreign keys prevent assignments or batches from referencing missing rows. Existing foreign-key violations are checked at database open; a regression test verifies opening is refused for a deliberately corrupt database.
- Student deactivation is a soft state change; historical assignments are not erased as a side effect.

## Migration policy and verification

- Schema version 1 was the initial development schema. Version 2 added four assignment integrity triggers. Version 3 added two assignment scope-key triggers.
- `onUpgrade` installs the appropriate triggers for v1/v2 databases; it does not drop or recreate user tables.
- The in-memory SQLite v1 fixture exercises Drift's actual v1-to-v3 upgrade path, preserves seeded institute/student/class/batch/assignment records, checks that the six v1 indexes remain, verifies all six v2/v3 triggers, and tests that overlap enforcement still works after migration. The fixture's frozen DDL matches the v1 table columns, foreign keys, boolean constraints, and six declared indexes. Drift's text-length constraints are client-side validation, not SQLite table CHECK constraints, so they are intentionally absent from the frozen SQL fixture. Re-review this fixture whenever the historical v1 schema changes.
- Regression tests exercise direct SQL inserts/updates against interval, class/batch, and scope-key invariants.
- CI run #28 passed pinned Flutter setup, dependency resolution, Drift code generation, `flutter analyze`, `flutter test`, and the generated-files step.
- No Gradle task, APK build, or device-level test is authorized or claimed.
- SQLite WAL mode is enabled for the app connection. Backup/restore consistency and device-level migration behavior remain unverified. Migration-failure rollback behavior still needs a dedicated regression test.

## Still out of scope

Money, fee ledgers, opening balances, payments, refunds, salary, discounts/credits, exams, results, certificates, backups and licensing are not part of this schema slice. They require their approved invariants and unresolved decisions P-01 through P-07 where applicable. Do not invent accounting semantics to fill schema gaps.

## Review gates before merge

1. Fresh CI must pass on the latest Phase 3 commit, including migration, analysis, and all tests.
2. Re-review the frozen v1 fixture whenever schema definitions change; it is manually maintained and can drift.
3. Commit a canonical schema export before the next schema-version change.
4. Add and verify a dedicated migration-failure rollback regression test before treating migration safety as closed.
5. Re-review the first schema against the approved product specification before adding financial tables.
6. PR #2 remains draft and must not be merged as part of this work. CI success alone is not product readiness.
