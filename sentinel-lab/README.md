# Microsoft Sentinel — Home Lab

> Full Sentinel deployment on Azure — configured from scratch via Azure CLI and Terraform.

## Architecture

```
Azure Tenant: mim972live.onmicrosoft.com
    └── Resource Group: SOC-QUEST-LAB (canadacentral)
        ├── Log Analytics Workspace: sentinel-lab
        │   └── Microsoft Sentinel (SecurityInsights)
        └── VM: CLIENT01 (Windows 11 Pro)
            └── Extension: AADLoginForWindows (Entra ID Join)
```

## Data Connectors

| Connector | Status | Table |
|---|---|---|
| Azure Activity Logs | Active | `AzureActivity` |
| Microsoft Defender XDR | Active | `SecurityAlert` |
| Entra ID Audit Logs | Active | `AuditLogs` |
| Windows Security Events (AMA) | Active | `SecurityEvent` |

## Analytics Rules Deployed

| Rule | Tactic | Severity | Status |
|---|---|---|---|
| Password Spray Detection | Credential Access | High | Active |
| Brute Force on Windows | Credential Access | Medium | Active |
| New Admin Account Created | Persistence | High | Active |
| Suspicious PowerShell Execution | Execution | Medium | Active |
| Off-Hours Sign-in | Initial Access | Low | Active |

## Rebuild

The entire lab is defined in Terraform — see [`../terraform/`](../terraform/).

```bash
terraform init
terraform apply -var="admin_password=<your-password>"
# ~5 minutes to full deployment
```
