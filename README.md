# Aymerick Victoire — Security Engineer

> Azure Security | Microsoft Sentinel | KQL | Terraform | Entra ID

[![AZ-500](https://img.shields.io/badge/AZ--500-In%20Progress-orange?logo=microsoft-azure)](https://learn.microsoft.com/en-us/certifications/exams/az-500)
[![SC-200](https://img.shields.io/badge/SC--200-Planned-blue?logo=microsoft)](https://learn.microsoft.com/en-us/certifications/exams/sc-200)
[![CompTIA A+](https://img.shields.io/badge/CompTIA%20A%2B-In%20Progress-red)](https://www.comptia.org/certifications/a)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-purple?logo=terraform)](https://www.terraform.io/)

---

## About

Sys & network admin with 3+ years experience managing 114 workstations across 4 sites (GLPI, Intune, Entra ID).  
Transitioning to **Security Engineer** — specializing in Azure cloud security, infrastructure hardening, and detection engineering.

**Target:** Security Engineer in Montreal (PVT 2026)  
**Stack:** Azure Security · Microsoft Sentinel · Defender XDR · KQL · Terraform · PowerShell · Entra ID

---

## Repository Structure

```
soc-quest/
├── terraform/              ← Azure lab infrastructure as code
├── kql/                    ← Detection & threat hunting queries
│   ├── authentication/     ← Brute force, password spray, impossible travel
│   ├── persistence/        ← New admin accounts, scheduled tasks
│   ├── lateral-movement/   ← Pass-the-hash, WMI, PsExec
│   ├── exfiltration/       ← DNS tunneling, large upload detection
│   └── threat-hunting/     ← Kerberoasting, LSASS, LOtL binaries
├── powershell/             ← Administration & security scripts
│   ├── administration/     ← User management, audit, reporting
│   └── security/           ← Hardening, log analysis, IR scripts
├── sentinel-lab/           ← Sentinel deployment & analytics rules
└── incident-writeups/      ← Documented investigations
```

---

## Azure Security Lab

Home lab running on Azure — fully reproducible via Terraform.

| Component | Status |
|---|---|
| Entra ID | ✅ Users, groups, RBAC configured |
| Microsoft Sentinel | ✅ Analytics rules + data connectors |
| Defender XDR | ✅ Unified security portal |
| CLIENT01 (Win11 Pro) | ✅ Entra ID joined |
| Infrastructure as Code | ✅ Full lab deployable in ~5 min |

**Rebuild the entire lab from scratch:**
```bash
git clone https://github.com/AymerickVic/soc-quest
cd soc-quest/terraform
terraform init
terraform apply -var="admin_password=<your-password>"
```

---

## Certifications

| Certification | Phase | Status |
|---|---|---|
| CompTIA A+ (220-1201/1202) | 1 | 🔄 In progress |
| CompTIA Network+ | 1 | ⏳ Planned |
| SC-900 | 2 | ⏳ Planned |
| AZ-104 | 3 | ⏳ Planned |
| **AZ-500** ⭐ | **3 — Main target** | ⏳ Planned |
| SC-200 | 3 | ⏳ Planned |

---

## Contact

- **LinkedIn:** [Aymerick Victoire](https://linkedin.com/in/)
- **Email:** victoireaymerick@gmail.com
- **Location:** Martinique → Montreal 2026
