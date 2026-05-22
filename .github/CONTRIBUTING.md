# Contributing

Thanks for your interest in improving this SOC lab portfolio.

## What's Welcome

- Bug fixes in KQL queries (false positive reduction, syntax errors)
- Additional MITRE ATT&CK coverage for missing techniques
- Terraform improvements (cost optimization, security hardening)
- New incident write-ups following the existing format

## KQL Query Standards

Each `.kql` file must include a header block:

```kql
// ============================================================
// [Query Name]
// ============================================================
// Description : What it detects
// MITRE ATT&CK : T[ID] — Technique Name
// Data source  : Table name (connector required)
// Severity     : Low / Medium / High
// Tuning notes : How to reduce false positives
// ============================================================
```

## Incident Write-up Format

Follow the structure in `incident-writeups/` :
- Executive Summary
- Artifacts Analyzed
- Attack Timeline (table)
- MITRE ATT&CK Mapping (table)
- Indicators of Compromise (table)
- Lessons Learned

## Commit Convention

```
feat: add new KQL query for X
fix: reduce false positives in brute-force detection
docs: add incident write-up for Y
terraform: add NSG rule for Z
```

## Pull Requests

- One feature/fix per PR
- Reference the MITRE technique ID if applicable
- Test KQL queries in a Sentinel instance before submitting
