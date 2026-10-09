# Migration Evidence

Keep migration evidence here only after a migration has actually been implemented and executed against the stated source/target schemas.

For each migration, record:
- Migration ID and source/target schema versions.
- Exact repository commit and toolchain versions.
- Test database fixture provenance (synthetic data only unless separately authorized).
- Before/after row counts and relevant invariants.
- `PRAGMA integrity_check` and `PRAGMA foreign_key_check` results.
- Business invariant checks (balances/allocations, assignment overlap, receipt uniqueness, result/certificate links, managed-file references as applicable).
- Upgrade test result, failure/rollback test result, and logs with secrets/personal data redacted.
- Reviewer, date, and decision status.

Never store production databases, personal data, signing keys, credentials or unredacted sensitive logs in this folder.
