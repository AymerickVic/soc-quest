# Security Policy

## Scope

This repository contains educational security content: KQL detection queries,
PowerShell scripts, Terraform infrastructure code, and incident write-ups.

**All content is intended for lab environments only.**

## Reporting a Vulnerability

If you discover a security issue in this repository (e.g., accidentally committed
credentials, insecure Terraform configuration), please:

1. **Do not open a public issue**
2. Email: victoireaymerick@gmail.com
3. Include: description, reproduction steps, potential impact

I will respond within 72 hours.

## Sensitive Data

This repo is configured to never commit:
- `terraform.tfstate` / `*.tfstate.*`
- `*.tfvars` / `*.tfvars.json`
- `.terraform/` directory
- Any credentials or secrets

See [`.gitignore`](../terraform/.gitignore) for the full list.
