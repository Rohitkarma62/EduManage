# Filesystem Reconciliation Report

- Repository: `Rohitkarma62/EduManage`
- Target branch: `main`
- Baseline scaffold commit: `6b21cc79b99e9f240f6023cde3d3722c6d887cb2`
- Specification reviewed: `EduManage_Offline_Full_Developer_Reconstruction_Specification.pdf`, version 1.0, planning baseline 2026-10-09
- Review type: filesystem and architecture-plan reconciliation only
- Build/tests: not run
- Application source implementation: not present at this review point

## Executive summary

The scaffold broadly matches the proposed feature boundaries and layered architecture in Section 3 of the specification. It is a useful directory map, but it is not a Flutter project yet. The specification explicitly describes its filesystem as a proposed target, not proof of implementation.

No business rule, database schema, migration, PDF workflow, license verifier, or backup/restore behavior was implemented as part of this reconciliation. The goal is to make the repository plan honest, coherent, and safer for the next implementation phase.

## Findings and decisions

### R-01 — Project bootstrap files are intentionally absent
**Severity: Blocker for compilation, not a scaffold defect.**

Missing: `pubspec.yaml`, `pubspec.lock`, `analysis_options.yaml`, `lib/main.dart`, app widget, Flutter platform scaffold and generated Drift output.

Decision: do not hand-author a fake lockfile or guess dependency versions. When implementation is authorized, use a pinned Flutter/Dart toolchain, generate the standard Android project files with Flutter tooling, add dependencies, run dependency resolution, and commit the resulting lockfile. This scaffold must not be described as buildable.

### R-02 — Runtime storage must not be confused with repository directories
**Severity: High, data-safety boundary.**

SQLite database, private managed files, temporary files, backups, license imports and generated customer documents belong in app-private runtime storage, not in source-controlled folders. The repository contains only code, assets intended for bundling, tests, and documentation. The actual runtime directory paths are platform-specific and must be implemented and tested, not assumed from this folder tree.

### R-03 — Android directories are not a generated Android project
**Severity: High, build-readiness clarity.**

The current `android/app/src/main` and `android/app/src/test` paths are placeholders only. They do not contain Gradle wrapper/configuration, manifest, Kotlin activity, signing configuration, or a complete Flutter Android runner. Prefer generating the platform project using Flutter tooling when bootstrapping, rather than gradually hand-constructing platform files.

### R-04 — Feature layering is a convention, not an obligation to create empty files everywhere
**Severity: Medium, maintainability.**

Feature folders use `presentation/`, `domain/`, and `data/` as architectural boundaries. Use all three where the feature warrants them. Simple presentation-only features need not contain artificial empty layers. Keep domain rules independent of Flutter widgets; keep persistence behind repositories/DAOs; avoid duplicate calculations in screens.

### R-05 — Core subfolders should be implementation-oriented and explicit
**Severity: Medium.**

The specification calls for named components including:
- Database: `app_database.dart`, schema version, tables, DAOs, migrations and seeds.
- Files: managed file service, owner reference, manifest, integrity and retention policy.
- PDF: service, document snapshots and local templates.
- Backup: service, manifest, verifier, restore service and durable restore journal.
- Licensing: payload, signature verifier, entitlement service and import service.
- Security: secret redaction.

These are target responsibilities only. Do not add empty Dart source files with fake APIs merely to make the tree look complete. Add each source file with its implementation and tests in the relevant feature phase.

### R-06 — Required governance/evidence documents need explicit tracking
**Severity: High for safe handoff.**

The specification expects decision tracking and migration evidence. Add a decision log template and a migration-evidence README describing what evidence belongs there. Do not fabricate approvals, migration test results, or implementation evidence.

### R-07 — Data, build, and signing secrets must stay out of Git
**Severity: Critical security rule.**

Never commit private license-signing keys, Android release keystores/passwords, real student/staff data, production backups, access tokens, or secrets in logs. Public license verification material may be bundled only after the signing format/key management is approved. Add ignore rules when the actual Flutter bootstrap is created; verify that ignore patterns do not hide required source or generated files.

### R-08 — Offline-first and visual design constraints remain acceptance criteria
**Severity: High product requirement.**

Core CRUD, finance, attendance, local PDF generation and backup/restore must not depend on network calls. Keep the locked reference design tokens (navy `#17324D`, teal `#0F766E`, canvas `#F5F7FA`, white surfaces and the supplied screen hierarchy) unchanged. Exact visual parity still requires the original per-screen assets/measurements and device validation. A folder scaffold does not prove either offline behavior or UI parity.

## Reconciled target tree

The repository structure document is the canonical, human-readable map. The practical implementation order should be:

1. Flutter project bootstrap and pinned dependencies.
2. App shell, theme tokens, startup and navigation skeleton.
3. Drift database foundation: schema version, tables, DAOs, constraints, migration strategy and migration tests.
4. Domain contracts and tests for financial ledger, assignment history, attendance and academic versioning.
5. Managed file ownership/retention, offline PDF snapshots, then backup/restore protocol.
6. Offline license verification and operation-level entitlement matrix.
7. Feature UI implementation against the locked reference.
8. Static analysis, unit/database/migration/workflow tests, offline device tests, then APK build.

Do not start finance or migration implementation until pending policies P-01/P-02 and relevant schema decisions are resolved. Do not claim restore readiness until P-03/P-06 and backup invariants have evidence. Do not gate or enable individual actions solely by tier until P-07's operation-level entitlement matrix is approved.

## Pending decisions preserved

The following remain unresolved in the developer specification and are not silently decided by this reconciliation:
- P-01: opening-balance provenance and ambiguous legacy balance handling.
- P-02: refund lifecycle/cancellation stages.
- P-03: exact PDF-byte retention by document type.
- P-04: salary correction vs actual cash recovery.
- P-05: result correction and certificate review.
- P-06: restore journal/audit survival architecture.
- P-07: operation-level license entitlement matrix.

Existing SC-01 through SC-10 decisions remain planning decisions, not implementation evidence. CC-01 through CC-16 consistency items and B-01 through B-20 evidence blockers remain open until supported by source/tests or approved decisions.

## Verification result

- Repository identity and branch were checked through GitHub.
- The scaffold tree was readable and not truncated.
- This reconciliation updates planning documentation only.
- No Dart implementation, database migration, dependency lockfile, test, or build was created or executed.
- The repository is still **not a compilable Flutter app**.
