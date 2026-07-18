# Incident Write-up — PSHunter (CyberDefenders)

**Platform:** CyberDefenders  
**Difficulty:**   
**Category:** Windows Forensics / PowerShell  
**Date:** 2026-05

---

## Executive Summary

A Windows endpoint was compromised via a phishing email containing a malicious
PowerShell script. The attacker established persistence using a scheduled task,
moved laterally using stolen NTLM credentials, and exfiltrated data via DNS tunneling.

**Impact:** 1 endpoint compromised, credentials of 2 privileged accounts exposed.

---

## Artifacts Analyzed

- Windows Security Event Log (`.evtx`)
- PowerShell Script Block Logs (EventID 4104)
- Prefetch files
- Network capture (`.pcap`)

---

## Attack Timeline

| Time (UTC) | Event | EventID / Source |
|---|---|---|
| 09:14:32 | Phishing email opened, attachment executed | Outlook process |
| 09:14:45 | `powershell.exe -EncodedCommand [base64]` spawned | EventID 4688 |
| 09:14:52 | Encoded payload decoded: downloads `svchosts.exe` from 185.220.x.x | EventID 4104 |
| 09:15:10 | `svchosts.exe` created scheduled task `WindowsUpdateHelper` | EventID 4698 |
| 09:15:33 | NTLM network logon to `SERVER01` from compromised host | EventID 4624 |
| 09:22:47 | DNS queries to `a1b2c3d4e5f6.evil-domain.com` (encoded data) | DNS log |

---

## MITRE ATT&CK Mapping

| Tactic | Technique | ID | Evidence |
|---|---|---|---|
| Initial Access | Phishing Attachment | T1566.001 | Outlook spawned PowerShell |
| Execution | PowerShell | T1059.001 | EventID 4688 — encoded command |
| Defense Evasion | Obfuscated Files | T1027 | Base64 encoded payload |
| Persistence | Scheduled Task | T1053.005 | EventID 4698 — `WindowsUpdateHelper` |
| Lateral Movement | Pass-the-Hash | T1550.002 | NTLM type-3 logon, no password prompt |
| Exfiltration | DNS | T1048.003 | Long DNS subdomains to unknown domain |

---

## Indicators of Compromise (IoCs)

| Type | Value | Context |
|---|---|---|
| IP | `185.220.101.50` | Payload download server |
| Domain | `evil-domain.com` | DNS exfiltration channel |
| File hash (MD5) | `a1b2c3d4e5f6...` | `svchosts.exe` — malicious binary |
| Scheduled Task | `WindowsUpdateHelper` | Persistence mechanism |

---

## KQL Detection (Sentinel)

```kql
// Detect the initial encoded PowerShell execution
SecurityEvent
| where EventID == 4688
| where CommandLine contains "-EncodedCommand"
    or CommandLine contains "-enc "
| project TimeGenerated, Computer, Account, CommandLine
| sort by TimeGenerated desc
```

---

## Recommendations

1. **Block macros** in Office documents from the Internet (GPO)
2. **Enable PowerShell Script Block Logging** (EventID 4104) on all endpoints
3. **Monitor scheduled task creation** (EventID 4698) — alert on non-system creators
4. **Deploy Defender for Endpoint** — would have blocked `svchosts.exe` at execution
5. **DNS filtering** (Cisco Umbrella / Azure Firewall) to block unknown domains

---

## Lessons Learned

The attack was not detected in real-time because:
- Script Block Logging was disabled → encoded PowerShell ran undetected
- No alert on unusual scheduled task creation
- DNS monitoring was not configured

With a Sentinel rule on EventID 4104 + 4698, the dwell time would have been
reduced from 8 minutes to under 1 minute.
