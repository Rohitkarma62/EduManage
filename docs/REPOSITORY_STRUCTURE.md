# EduManage Offline Repository Structure

Status: **scaffold only**. This documents the planned Flutter/Dart project layout; it does not mean application code, database migrations, tests, Android configuration, or a working APK already exist.

## Planned structure

```text
.
├── README.md
├── pubspec.yaml                         # to be added with dependency decisions
├── analysis_options.yaml                # to be added
├── lib/
│   ├── main.dart                        # app entry point
│   ├── app/
│   │   ├── app.dart
│   │   ├── router/                      # GoRouter routes, names, guards
│   │   ├── theme/                       # colors, typography, spacing, theme
│   │   └── startup/                     # startup controller and screen
│   ├── core/
│   │   ├── database/                    # Drift database, schema version, tables, DAOs, migrations, seeds
│   │   ├── files/                       # managed files, ownership, manifest, integrity, retention
│   │   ├── pdf/                         # offline PDF service, snapshots, templates
│   │   ├── backup/                      # backup manifest, verification, restore service and journal
│   │   ├── licensing/                   # payload, signature verification, entitlements, import
│   │   ├── security/
│   │   ├── validation/
│   │   ├── errors/
│   │   └── utils/
│   ├── features/
│   │   ├── onboarding/
│   │   ├── dashboard/
│   │   ├── students/
│   │   ├── classes/
│   │   ├── batches/
│   │   ├── assignments/
│   │   ├── fees/
│   │   ├── payments/
│   │   ├── discounts_credits/
│   │   ├── refunds/
│   │   ├── attendance/
│   │   ├── reports/
│   │   ├── staff/
│   │   ├── salary/
│   │   ├── expenses/
│   │   ├── exams/
│   │   ├── results/
│   │   ├── certificates/
│   │   ├── settings/
│   │   ├── backup_restore/
│   │   ├── license/
│   │   └── about_diagnostics/
│   │       # Feature modules may use presentation/, domain/, and data/
│   └── shared/                          # widgets, forms, dialogs, states, formatters, accessibility
├── test/
│   ├── unit/
│   ├── database/
│   ├── migrations/
│   ├── workflows/
│   ├── financial_ledger/
│   ├── attendance/
│   ├── backup_restore/
│   ├── licensing/
│   └── golden_ui/
├── assets/
│   ├── branding/
│   ├── icons/
│   ├── fonts/
│   └── pdf_templates/
├── docs/
│   ├── migration_evidence/
│   ├── decision_log.md                   # to be added
│   └── product_specification.pdf         # add approved specification artifact
└── android/                              # Flutter-generated Android project configuration
```

## Architectural rules

- Flutter/Dart; Riverpod for state management; GoRouter for navigation.
- SQLite via Drift; migrations must be explicit, versioned, and tested.
- Keep presentation, domain/business rules, and data access separated within feature modules.
- Core workflows and PDF generation must work offline.
- Store business data in local SQLite; managed files use a dedicated local file service.
- Never commit passwords, production data/backups, release signing secrets, or private license-signing keys.
- Keep this structure aligned with the approved developer specification. Pending business policies must be resolved before implementing the affected workflow.

## Local device storage (runtime data, not repository files)

- `database/edumanage.sqlite`
- `files/branding/`
- `files/students/photos/`
- `files/documents/`
- `files/generated/receipts/`
- `files/generated/reports/`
- `files/generated/id_cards/`
- `files/generated/certificates/`
- `files/backups/`
- `files/temporary/`
- `shared_preferences/`

These are app-private runtime locations, not directories to commit with user records. The actual paths must be implemented using Android app storage APIs and verified on device.

## Current limitations

This scaffold intentionally contains directory placeholders only. It is not yet a compilable Flutter project because the app entry point, dependency manifest, generated Drift code, platform configuration, and feature implementation have not been created. No build or tests have been run.
