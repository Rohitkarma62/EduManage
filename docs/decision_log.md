# Decision Log

Record each accepted product/technical decision with date, decision ID, owner/approver, rationale, affected screens, tables, migrations, tests, compatibility impact and links to evidence.

## Template

- ID:
- Status: Proposed / Pending approval / Accepted / Superseded
- Date:
- Decision owner / approver:
- Context:
- Decision:
- Alternatives considered:
- Affected screens/modules:
- Affected tables/migrations:
- Required tests:
- Compatibility / backup / restore impact:
- Evidence links:
- Supersedes / superseded by:

## Open decisions (preserve as pending)

The product/business owner must approve these before implementation locks in related accounting, document-retention, restore or licensing behavior. No default is silently selected here.

### P-01 — Opening-balance provenance and ambiguous legacy balances
- Status: Pending approval
- Required outcome: define allowed provenance/source types, how opening balances are distinguished from ordinary receipts/credits, and how ambiguous legacy records are quarantined or reconciled without silently inventing ledger entries.
- Required evidence: approved examples and migration/reconciliation tests.
- Do not: infer a payment, credit, debt or opening balance from an ambiguous amount.

### P-02 — Refund lifecycle and cancellation
- Status: Pending approval
- Required outcome: define refund states, cancellation boundaries, reversal linkage, partial refunds and which transitions are permitted after a receipt or PDF has been issued.
- Required evidence: state-transition table and tests for duplicate requests, reversal integrity and terminal states.
- Do not: delete or rewrite historical payments to simulate a refund.

### P-03 — Exact PDF-byte retention by document type
- Status: Pending approval
- Required outcome: specify which document types retain the exact generated PDF bytes, which may be regenerated from a versioned snapshot, and how reissue/correction affects the original.
- Required evidence: document-type matrix and tests for byte retention, snapshot versioning and reissue.
- Do not: assume every PDF can be recreated identically from current records.

### P-04 — Salary correction versus actual cash recovery
- Status: Pending approval
- Required outcome: distinguish correcting a salary calculation/entry from recovering money already paid, including the accounting linkage and audit trail for each.
- Required evidence: approved examples for pre-payment correction, post-payment correction and actual recovery.
- Do not: treat an accounting correction as proof that cash was recovered.

### P-05 — Result correction and certificate review
- Status: Pending approval
- Required outcome: define correction/versioning of published results and when an issued certificate must be reviewed, superseded or reissued.
- Required evidence: result-version lifecycle, certificate linkage rules and tests.
- Do not: silently mutate a published result version or reuse an issued certificate number.

### P-06 — Restore journal and audit survival architecture
- Status: Pending approval
- Required outcome: specify how a durable restore journal and audit evidence survive database replacement, rollback, process termination and device restart.
- Required evidence: recovery protocol plus interruption/failure-injection tests.
- Do not: claim restore is safe based only on a successful backup file copy.

### P-07 — Operation-level license entitlement matrix
- Status: Pending approval
- Required outcome: map every protected operation to Basic, Professional and Premium; define read-only access on downgrade and import/invalid-license behavior.
- Required evidence: approved operation-by-tier matrix and tests for every protected operation, invalid license import, non-expiring licenses and data preservation.
- Do not: use screen visibility alone as the authorization boundary or delete data on downgrade.

## Approval gate

Until the authorized product/business owner approves P-01 through P-07, keep them pending and preserve the existing identifiers and meaning. Implementation may proceed only on independent work that does not make these decisions implicitly. Do not freeze a canonical production schema or claim accounting/licensing acceptance without the required evidence.
