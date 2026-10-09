# EduManage Offline Repository Structure

**Status:** proposed filesystem scaffold, reconciled against the developer reconstruction specification. This is a plan, not a verified snapshot of an implemented app.

## Repository contents and intent

- `lib/`: Flutter/Dart application source.
- `test/`: unit, database, migration, workflow, finance, attendance, backup/restore, licensing and UI golden tests.
- `assets/`: bundled assets only (branding, licensed fonts/icons and local PDF templates).
- `docs/`: approved product specification, decision log, reconciliation notes and migration evidence guidance.
- `android/`: Flutter-generated Android platform project. Current directories are placeholders, not a complete Android runner.
- `pubspec.yaml`, `pubspec.lock`, `analysis_options.yaml` and `lib/main.dart`: required bootstrap files that have not yet been created.

## Target source tree

```text
lib/
  main.dart
  app/
    app.dart
    router/             # GoRouter routes, names and entitlement/onboarding guards
    theme/              # locked design tokens, typography, spacing, theme
    startup/            # startup orchestration and initial screen
  core/
    database/           # Drift DB, schema version, tables, DAOs, migrations, seeds
    files/              # managed-file service, ownership, manifest, integrity, retention
    pdf/                # offline PDF service, immutable document snapshots, templates
    backup/             # consistent DB snapshot, manifest, verification, restore journal
    licensing/          # signed payload validation, public-key verification, entitlements
    security/           # secret redaction and safe diagnostics
    validation/
    errors/
    utils/
  features/
    onboarding/ dashboard/ students/ classes/ batches/ assignments/
    fees/ payments/ discounts_credits/ refunds/ attendance/ reports/
    staff/ salary/ expenses/ exams/ results/ certificates/ settings/
    backup_restore/ license/ about_diagnostics/
    # use presentation/, domain/, data/ where the feature actually needs each layer
  shared/
    widgets/ forms/ dialogs/ loading/ empty_states/ error_states/
    formatters/ accessibility/
test/
  unit/ database/ migrations/ workflows/ financial_ledger/
  attendance/ backup_restore/ licensing/ golden_ui/
assets/
  branding/ icons/ fonts/ pdf_templates/
docs/
  product_specification.pdf
  decision_log.md
  migration_evidence/
  RECONCILIATION.md
```

## Architecture and implementation rules

- Flutter/Dart; Riverpod; GoRouter; SQLite through Drift.
- Generate Android platform scaffolding with Flutter tooling; do not treat placeholder folders as build-ready.
- Keep presentation, domain/business rules, data access and infrastructure responsibilities separated.
- Core business workflows and PDF generation must function offline. Network availability must not be a prerequisite for local CRUD, fee transactions, attendance or reports.
- Money is stored as integer paise. Critical financial, assignment, attendance, result-publication and restore operations use explicit transaction/consistency boundaries and tests.
- Generated Drift files follow one documented and pinned generation workflow.
- Add code files when they contain real implementation, not merely to populate the tree.
- Keep the supplied visual reference locked: navy `#17324D`, teal `#0F766E`, canvas `#F5F7FA`, white surfaces and approved navigation/screen hierarchy.
- Never commit real student/staff data, production backups, passwords, access tokens, Android release keystores, or private license-signing keys.

## Runtime storage is separate from Git

The app will need app-private runtime locations for its SQLite database, managed files, generated documents, backups and temporary files. These are **not repository directories** and must not contain real user data in Git. Resolve platform-specific paths through the app's storage APIs and verify on Android devices.

## Current readiness

This repository is a filesystem/documentation scaffold only. It is not yet a compilable Flutter project. No application implementation, database schema/migration, dependency lockfile, tests or APK build is claimed.
