# EduManage Offline Repository Structure

**Status:** Target architecture and implementation plan, reconciled against the developer reconstruction specification. This is not a verified snapshot of a completed app.

## Current repository checkpoint

The `phase-2/flutter-bootstrap` branch contains the Flutter package bootstrap, generated Android platform scaffold, pinned Flutter version, dependency lockfile, a minimal app shell, strict analysis options, a CI workflow and one widget smoke test. GitHub Actions run #7 passed dependency resolution, `flutter analyze`, and `flutter test`:

https://github.com/Rohitkarma62/EduManage/actions/runs/37958071222

This is not evidence of a complete or release-ready app. No Gradle task, Flutter build, APK, release signing, emulator run, or device test has been performed. The Android application ID and release signing are still generated placeholders.

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
- Generate Android platform scaffolding with Flutter tooling; do not treat generated scaffolding as proof the product builds or is ready to release.
- Keep presentation, domain/business rules, data access and infrastructure responsibilities separated.
- Core business workflows and PDF generation must function offline. Network availability must not be a prerequisite for local CRUD, fee transactions, attendance or reports.
- Money is stored as integer paise. Critical financial, assignment, attendance, result-publication and restore operations use explicit transaction/consistency boundaries and tests.
- Generated Drift files follow one documented and pinned generation workflow.
- Add code files when they contain real implementation, not merely to populate the tree.
- Keep the supplied visual reference locked: navy `#17324D`, teal `#0F766E`, canvas `#F5F7FA`, white surfaces and approved navigation/screen hierarchy.
- Never commit real student/staff data, production backups, passwords, access tokens, Android release keystores, or private license-signing keys.

## Runtime storage is separate from Git

The app will need app-private runtime locations for its SQLite database, managed files, generated documents, backups and temporary files. These are **not repository directories** and must not contain real user data in Git. Resolve platform-specific paths through the app's storage APIs and verify on Android devices.

## Known scaffold items to resolve before release
- Replace the generated Android application ID `com.example.edumanage_offline` with the agreed permanent package ID.
- Replace the generated debug signing configuration with a properly managed release-signing process before release builds.
- Review the broad `*.pdf` ignore rule against the intended policy for versioned product specifications and approved PDF templates; do not force-add private/generated customer documents.

## Readiness
The current branch is a verified Flutter bootstrap with static analysis and a smoke test passing. It is **not** yet the complete EduManage product: the database schema/migrations, core business workflows, backup/restore, license validation, full UI, and their corresponding tests remain unimplemented. No APK/build verification is claimed.
