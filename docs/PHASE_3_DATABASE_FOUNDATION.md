# Phase 3: Database Foundation

**Status:** Database foundation v4 is implemented and the latest CI run passes. This is a verified database slice, not a complete product or release-ready application. PR #2 remains draft and must not be merged as part of this audit.

## Verified scope

- Local SQLite database in app-private application-support storage; no network or cloud dependency in this slice.
- Drift tables: institute settings, students, class groups, batches, and effective-dated student assignments.
- Foreign keys enabled and checked at database open. Existing foreign-key violations prevent normal opening.
- Student DAO supports create, active-list pagination, find, contact update, and soft deactivation.
- Classes/batches DAO added: normalized create, deterministic active lists, find-by-ID, archive instead of delete, duplicate-name scope enforcement through SQLite indexes, and refusal to add batches to archived/missing classes. Its new tests are awaiting the next CI result.
- Assignment DAO validates student/class/batch references, positive date ranges, and overlapping intervals in a transaction.
- SQLite triggers enforce assignment overlap, batch/class consistency, derived scope keys, and positive date ranges even for direct SQL writes.
- Class names are unique; batch names are unique within a class and may repeat in different classes.
- Student deactivation preserves the row and its assignment history.

## Schema and migration policy

- Schema version 1 is the frozen historical development schema used by the migration fixture.
- Version 2 added four assignment integrity triggers: batch/class consistency and overlap checks for inserts and updates.
- Version 3 added two derived assignment-scope-key triggers.
- Version 4 added two assignment date-range triggers and refuses migration if a legacy assignment has a non-null end date less than or equal to its start date.
- Upgrade trigger DDL runs inside a transaction. It does not intentionally repair or delete invalid legacy records.
- The in-memory v1 fixture exercises v1-to-v4 migration, seeded-data preservation, indexes, trigger installation, and post-migration integrity.
- Failure rollback regression tests cover failed v1, v2, and v3 upgrades. They verify schema version and existing rows/triggers survive and newly-created triggers are rolled back.
- The frozen v1 fixture is manually maintained. Re-review it whenever the historical schema changes.

## Latest repository verification

- Branch: `phase-3/database-foundation`
- Latest previously audited code commit: `c46e341bd74517c91ec8fbf418fa7be18c6fe966`. The classes/batches DAO and its tests were added afterward and are not yet verified at the time of this edit.
- Audit documentation commits: `141ab3610f2da562e866801970827dc5977b515f` and `ac09754fe8871770aa00f55e5a6a976bf6c31c74`.
- Latest successful CI for the prior database slice: [Run #57](https://github.com/Rohitkarma62/EduManage/actions/runs/38109233225), completed successfully at commit `cd46403007b384990c3ff96766df9faf472b45e5`. The new classes/batches DAO and tests were committed after that run, so a fresh CI run is required.
- Verified successful steps: pinned Flutter SDK setup, toolchain check, dependency resolution, Drift code generation, `flutter analyze`, `flutter test`, and generated-files step.
- Student DAO tests cover normalization, blank-name rejection, stable pagination, invalid pagination inputs, updates, missing IDs, and soft deactivation.
- Assignment tests cover foreign keys, missing references, uniqueness scopes, adjacent/overlapping ranges, invalid ranges, raw-SQL integrity enforcement, and change-reason normalization.
- No Gradle task, APK build, device test, or PR merge was run or claimed.

## Remaining boundaries and risks

- This slice does not implement the fee ledger, opening balances, payments, refunds, salary, discounts/credits, exams, results, certificates, backup/restore, or license enforcement. The unresolved product decisions P-01 through P-07 remain applicable; do not invent accounting or lifecycle rules to fill them.
- WAL is enabled, but device-level migration behavior and consistent backup/restore handling are not verified here.
- A canonical schema export should be committed before the next schema-version change.
- The Android application ID and release signing configuration still need product/release review in the appropriate phase.
- The current CI is a repository verification workflow, not a release build or device compatibility proof.

## Final audit disposition

**Database code/CI gate: PASS for the previously tested Phase 3 slice only.** The newly added classes/batches DAO and tests remain unverified until CI passes on the current head; do not claim the expanded scope has passed yet.

**Merge gate: NOT CLEARED.** Keep PR #2 open as draft until the base/integration review, canonical schema export, and approved product-spec reconciliation are completed. Do not merge merely because CI is green.
