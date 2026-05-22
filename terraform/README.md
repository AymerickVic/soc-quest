# Terraform — SOC Quest Lab

> Azure lab infrastructure as code. Full deployment in ~5 minutes.

## Architecture

```
Azure Subscription
└── Resource Group: SOC-QUEST-LAB (Canada Central)
    ├── Virtual Network: lab-vnet (10.0.0.0/16)
    │   └── Subnet: lab-subnet (10.0.1.0/24)
    ├── Network Security Group: client01-nsg
    │   └── Rule: Allow RDP inbound (port 3389)
    ├── Public IP: client01-pip
    ├── Network Interface: client01-nic
    ├── Virtual Machine: CLIENT01 (Windows 11 Pro)
    │   ├── Size: Standard_B2as_v2
    │   ├── Identity: SystemAssigned
    │   └── Extension: AADLoginForWindows (Entra ID Join)
    └── Log Analytics Workspace: sentinel-lab
        └── Microsoft Sentinel (SecurityInsights)
```

## Prerequisites

- [Terraform >= 1.7](https://developer.hashicorp.com/terraform/install)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Active Azure subscription

```bash
az login
az account set --subscription "<your-subscription-id>"
```

## Quick Start

```bash
# 1. Initialize providers
terraform init

# 2. Preview changes (dry run)
terraform plan -var="admin_password=<your-password>"

# 3. Deploy (~5 minutes)
terraform apply -var="admin_password=<your-password>"
```

## Inputs

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `subscription_id` | Azure subscription ID | `string` | `"98d5925f-..."` | no |
| `location` | Azure region | `string` | `"canadacentral"` | no |
| `resource_group_name` | Resource group name | `string` | `"SOC-QUEST-LAB"` | no |
| `admin_username` | VM administrator username | `string` | `"azureadmin"` | no |
| `admin_password` | VM administrator password | `string` | — | **yes** |

> **Security:** `admin_password` is marked `sensitive = true` — Terraform never prints it in logs or state diffs. Pass it via `-var` flag or `TF_VAR_admin_password` environment variable. Never write it in a `.tfvars` file committed to Git.

## Outputs

| Name | Description |
|---|---|
| `client01_public_ip` | Public IP for RDP access |
| `sentinel_workspace_id` | Log Analytics Workspace ID |
| `rdp_connection` | Ready-to-use mstsc command |

```bash
# After apply, get connection info
terraform output rdp_connection
# → mstsc /v:20.x.x.x
```

## Cost Estimate

| Resource | SKU | Estimated cost |
|---|---|---|
| VM CLIENT01 | Standard_B2as_v2 | ~$0.08/hr (~$58/month) |
| Log Analytics | PerGB2018, 30d retention | ~$2.76/GB ingested |
| Public IP | Basic | ~$0.004/hr |

> **Tip:** Run `terraform destroy` when not using the lab. Stop the VM (`az vm deallocate`) to pause compute costs while keeping the lab configuration.

## Teardown

```bash
# Destroy all resources (billing stops immediately)
terraform destroy -var="admin_password=<your-password>"
```

## Files

| File | Purpose |
|---|---|
| `main.tf` | Provider config, resource group |
| `network.tf` | VNet, subnet, NSG, public IP, NIC |
| `compute.tf` | Windows 11 VM, Entra ID extension |
| `sentinel.tf` | Log Analytics workspace, Sentinel |
| `variables.tf` | Input variable definitions |
| `outputs.tf` | Output values post-deploy |
