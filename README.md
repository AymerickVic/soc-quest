# SOC Quest — Portfolio Aymerick Victoire

> Parcours d'apprentissage vers un poste de **SOC T2 Analyst à Montréal** — environnement Microsoft dominant.

![Status](https://img.shields.io/badge/Status-En%20cours-blue)
![CompTIA A+](https://img.shields.io/badge/CompTIA%20A%2B-En%20cours-orange)
![CompTIA Network+](https://img.shields.io/badge/CompTIA%20Network%2B-En%20cours-orange)

---

## Qui suis-je

Admin réseau en Martinique, j'ai géré 114 postes sur 4 sites (GLPI, Intune, Entra ID).  
Mon objectif : intégrer un SOC canadien en tant qu'analyste T2, spécialisé sur la stack Microsoft Defender / Sentinel.

---

## Stack Microsoft

| Composant | Statut |
|---|---|
| Microsoft 365 Business Premium | Actif |
| Microsoft Intune | Déployé |
| Entra ID | Actif |
| Defender for Endpoint | Actif |
| Microsoft Sentinel | Lab en cours |

---

## Projets

### KQL Collection
Bibliothèque de règles d'analytics KQL organisée par catégorie MITRE ATT&CK.  
Détections : brute force, Kerberoasting, LSASS dump, lateral movement, exfiltration DNS.

### Sentinel Lab
Déploiement d'un Microsoft Sentinel sur tenant M365 Developer.  
Règles d'analytics, playbooks Logic Apps, et captures de preuves visuelles.

### Incident Write-ups
Rapports d'incidents résolus sur CyberDefenders et LetsDefend.  
Format SOC professionnel : timeline, IOCs, MITRE mapping, recommandations.

### Lab Active Directory
Environnement Proxmox avec Windows Server 2022 et clients Windows 10/11.  
Domaine `lab.local` — scripts d'administration, GPO documentées, scénarios de support.

---

## Structure du dépôt

```
soc-quest/
├── powershell/
│   ├── administration/     ← scripts admin Windows
│   ├── forensics/          ← scripts investigation SOC
│   └── lab-ad/             ← scripts spécifiques au lab AD
├── kql/
│   ├── authentication/     ← détections connexions
│   ├── persistence/        ← détections persistance
│   ├── lateral-movement/   ← détections mouvement latéral
│   ├── exfiltration/       ← détections exfiltration
│   └── threat-hunting/     ← requêtes hunting avancées
├── lab-active-directory/
│   ├── setup/              ← scripts installation AD
│   ├── gpo/                ← configs GPO documentées
│   └── scenarios/          ← scénarios de support
├── sentinel-lab/
│   ├── analytics-rules/    ← règles d'analytics exportées
│   ├── playbooks/          ← Logic Apps documentées
│   └── screenshots/        ← preuves visuelles
├── incident-writeups/      ← write-ups CyberDefenders/LetsDefend
└── notes/                  ← notes de cours par compétence
```

---

## Certifications

| Certification | Statut | Cible |
|---|---|---|
| CompTIA A+ | En cours | Phase 1 |
| CompTIA Network+ | En cours | Phase 1 |
| MD-102 | Verrouillé | Phase 2 |
| SC-900 | Verrouillé | Phase 2 |
| SC-200 | Verrouillé | Phase 3 |
| AZ-500 | Verrouillé | Phase 4 |

---

## Ressources

- [Microsoft Learn](https://learn.microsoft.com)
- [MITRE ATT&CK](https://attack.mitre.org)
- [MustLearnKQL](https://github.com/rod-trent/MustLearnKQL)
- [TryHackMe](https://tryhackme.com)
- [KQL Playground](https://dataexplorer.azure.com/clusters/help/databases/Samples)
