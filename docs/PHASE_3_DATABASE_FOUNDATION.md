# Phase 3: Database Foundation

**Status:** Initial local database foundation implemented. SQLite-level assignment integrity triggers and a schema-version-2 upgrade path are included. CI run #13 passed the migration test, analysis, and Flutter test suite. Follow-up migration compatibility checks are now being strengthened; this is not product-complete or release-ready.

## Scope of this first slice

- Local SQLite database opened from app-private application-support storage.
- Drift schema version 2. Version 2 adds SQLite triggers and upgrades existing version-1 databases without rebuilding their tables.
- Institute settings, students, class groups, batches, and effective-dated student assignments.
- Foreign-key enforcement enabled before normal queries; PRAGMA foreign_key_check is checked when opening the database.
- Basic local student create/list/find/update-contact/deactivate operations.
- Student DAO tests for local create/read, blank-name rejection, and soft deactivation.
- Assignment tests for adjacent half-open intervals, overlap rejection, batch/class mismatch, direct foreign-key rejection, uniqueness scopes, and non-positive interval rejection.
- No network dependency and no cloud storage.

## Schema integrity rules

- Class names are unique; batch names are unique within a class. The same batch name may exist in different classes.
- Student assignment intervals are half-open: [effective_from, effective_to); a null end means currently open-ended.
- DAO validation rejects overlapping intervals and a batch/class mismatch before writing.
- SQLite triggers also reject overlapping assignments and batch/class mismatches for direct SQL writes, so bypassing the DAO does not bypass these invariants.
- Foreign keys prevent assignments or batches from referencing missing rows. Foreign-key violations are checked at database open.
- Student deactivation is a soft state change; historical assignments are not erased as a side effect.

## Migration policy and verification

- Schema version 1 was the initial development schema. Version 2 adds integrity triggers.
- onUpgrade installs the new triggers for existing version-1 databases; it does not drop or recreate user tables.
- Keep every future schema change behind an incremented schemaVersion and an explicit onUpgrade path. Never change an already-shipped schema in place without a migration.
- A real in-memory SQLite v1 fixture now exercises Drift's v1-to-v2 upgrade path, preserves seeded institute/student/class/batch/assignment records, checks that the six v1 indexes remain, verifies the four v2 triggers, and tests that overlap enforcement still works after migration. The fixture's frozen DDL must be kept aligned with the historical v1 schema when that schema changes.
- CI runs Drift code generation, flutter analyze, and flutter test. No Gradle task, APK build, or device-level test is authorized or claimed.
- SQLite WAL mode is enabled for the app connection. Backup/restore consistency and device-level migration behavior remain unverified.

## Still out of scope

Money, fee ledgers, opening balances, payments, refunds, salary, discounts/credits, exams, results, certificates, backups and licensing are not part of this schema slice. They require their approved invariants and unresolved decisions P-01 through P-07 where applicable. Do not invent accounting semantics to fill schema gaps.

## Review gates before merge

1. Fresh CI must pass on the latest Phase 3 commit, including migration, analysis, and all tests.
2. Review the frozen v1 fixture against the actual historical v1 DDL; it is manually maintained and can drift if not reviewed carefully.
3. Commit a canonical schema export before the next schema-version change.
4. Re-review the first schema against the approved product specification before adding financial tables.
5. PR #2 remains draft and must not be merged as part of this work. CI success alone is not product readiness.
