# Security Quest — Portfolio Aymerick Victoire

> Parcours d'apprentissage vers un poste de **Security Engineer à Montréal** — spécialisation Azure Security & Infrastructure.

![Status](https://img.shields.io/badge/Status-En%20cours-blue)
![CompTIA A+](https://img.shields.io/badge/CompTIA%20A%2B-En%20cours-orange)
![AZ--104](https://img.shields.io/badge/AZ--104-En%20cours-orange)
![AZ--500](https://img.shields.io/badge/AZ--500-Phase%203-red)

---

## Qui suis-je

Admin réseau & systèmes en Martinique — 3 ans d'expérience (114 postes, 4 sites, GLPI, Intune, Entra ID).  
Mon objectif : devenir **Security Engineer à Montréal**, spécialisé sur la stack Azure Security (AZ-500, SC-200, Terraform).

---

## Stack & Compétences

| Domaine | Technologies | Niveau |
|---|---|---|
| Cloud Identity | Entra ID, RBAC, PIM | 🟧 Débutant |
| SIEM | Microsoft Sentinel, KQL | 🟧 Débutant |
| Endpoint Security | Defender XDR, Defender for Cloud | 🟫 Notions |
| Network Security | NSG, Azure Firewall, Private Endpoints | 🟫 Notions |
| IaC Security | Terraform, tfsec, Checkov | ⬜ À venir |
| Scripting | PowerShell, Azure CLI | 🟧 Débutant |

---

## Projets

### Azure Security Lab
Lab Azure complet : Entra ID, RBAC, Sentinel, Defender for Cloud sur tenant mim972live.onmicrosoft.com  
Sentinel configuré avec Analytics Rules, Data Connectors, KQL custom.

### KQL Collection
Bibliothèque de règles de détection KQL organisée par catégorie MITRE ATT&CK.  
Détections : brute force, password spray, Kerberoasting, lateral movement, exfiltration DNS.

### Incident Write-ups
Rapports d'investigations sur CyberDefenders et LetsDefend.  
Format professionnel : timeline, IoCs, MITRE mapping, recommandations.

### IaC Security *(Phase 4)*
Infrastructure Azure déployée via Terraform + scanning sécurité avec tfsec/Checkov.  
Pipeline GitHub Actions avec OIDC (pas de credentials statiques).

---

## Structure du dépôt

```
security-quest/
├── powershell/
│   ├── administration/     ← scripts admin Windows/Azure
│   └── forensics/          ← scripts investigation
├── kql/
│   ├── authentication/     ← détections connexions
│   ├── persistence/        ← détections persistance
│   ├── lateral-movement/   ← détections mouvement latéral
│   └── threat-hunting/     ← requêtes proactives
├── sentinel-lab/
│   ├── analytics-rules/    ← règles .kql documentées
│   ├── playbooks/          ← Logic Apps documentées
│   └── screenshots/        ← preuves visuelles
├── terraform/              ← IaC Azure sécurisé (Phase 4)
└── incident-writeups/      ← investigations documentées
```

---

## Roadmap certifications

| Cert | Priorité | Phase | Statut |
|---|---|---|---|
| CompTIA A+ 220-1201/1202 | Fondations | 1 | En cours |
| CompTIA Network+ | Fondations | 1 | À venir |
| SC-900 | Cloud baseline | 2 | À venir |
| AZ-104 | Prérequis AZ-500 | 3 | À venir |
| AZ-500 ⭐ | **Cible principale** | 3 | À venir |
| SC-200 | Détection cloud | 3 | À venir |

---

## Contact

- LinkedIn : [Aymerick Victoire](https://linkedin.com/in/)
- Email : victoireaymerick@gmail.com