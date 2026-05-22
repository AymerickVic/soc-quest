# KQL Detection Queries

> Kusto Query Language queries for Microsoft Sentinel — organized by MITRE ATT&CK tactic.

Each file follows this format:
- **Description** of what it detects
- **MITRE ATT&CK** technique reference
- **Data source** required
- **Tuning notes** to reduce false positives

## Structure

| Folder | MITRE Tactic | Queries |
|---|---|---|
| `authentication/` | Initial Access, Credential Access | 3 |
| `persistence/` | Persistence | 2 |
| `lateral-movement/` | Lateral Movement | 2 |
| `exfiltration/` | Exfiltration | 1 |
| `threat-hunting/` | Multiple | 3 |

## Usage

Import directly into Microsoft Sentinel → Logs, or save as Analytics Rules.
