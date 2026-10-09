# Phase 3: Database Foundation

**Status:** In progress. Initial Drift schema and student DAO source have been added on `phase-3/database-foundation`. Generated Drift code and runtime verification have not been run. Do not describe this phase as complete yet.

## Scope of this first slice

- Local SQLite database opened from app-private application-support storage.
- Drift schema version 1.
- Institute settings, students, class groups, batches, and effective-dated student assignments.
- Foreign-key enforcement and WAL mode.
- Basic local student create/list/find/update-contact/deactivate operations.
- No network dependency and no cloud storage.

## Initial schema decisions

- Student deactivation is a soft state change; historical assignments should not be erased as a side effect.
- Class and batch names are unique within their intended scope.
- Student assignment intervals are half-open: `[effective_from, effective_to)`; a null end means currently open-ended.
- `assignment_scope_key` is non-null to avoid relying on SQLite's ambiguous NULL behavior for scoped uniqueness. Assignment creation/update logic must validate class/batch consistency and reject overlapping effective intervals inside a database transaction before this can be treated as enforced.
- Money, fee ledgers, opening balances, payments, refunds, salary, discounts/credits, exams, results, certificates, backups and licensing are intentionally not part of schema v1. They require their specific approved invariants and unresolved decisions P-01 through P-07 where applicable.

## Required next implementation gates

1. Run the pinned Drift code generator and commit the generated schema code.
2. Add schema snapshot/export and a documented migration test strategy before introducing schema version 2.
3. Add database tests for fresh creation, foreign-key enforcement, student validation/soft deactivation, class/batch uniqueness, and assignment interval invariants.
4. Add assignment DAO operations with atomic overlap checks and class/batch consistency validation.
5. Review the first schema against the approved product specification before adding financial tables. Do not invent opening-balance or refund semantics to fill schema gaps.
6. After code generation and explicit authorization, run `flutter analyze` and `flutter test` in CI. No Gradle task, Flutter build or APK is part of this slice.

## Important limitations

- The Drift generated part file `app_database.g.dart` is not committed yet. Code generation is required before this code can compile.
- Schema version 1 is the first development schema, not a promise of production migration compatibility. Once user data exists, schema changes require migration tests and backup/restore compatibility review.
- No runtime database, migration, or device behavior has been verified at this stage.
