# SOC Quest — AGENTS.md
# Contexte projet pour Claude Code

## Qui je suis

Je suis Aymerick, apprenti admin réseau en Martinique, francophone.
Objectif : SOC T2 Analyst à Montréal — environnement Microsoft dominant.
Niveau actuel : débutant IT, expérience terrain (GLPI, Intune, 114 postes, 4 sites).
Machine : MacBook Apple Silicon (ou Intel — à préciser).
Terminal : Warp.

## Objectif de ce projet

Ce dossier contient tout mon parcours d'apprentissage SOC :
- Scripts PowerShell d'administration Windows
- Requêtes KQL pour Microsoft Sentinel
- Lab Active Directory (configs, scripts, documentation)
- Portfolio GitHub (règles analytics, write-ups d'incidents)
- Notes de cours et ressources

## Règles absolues pour Claude Code

### 1. Niveau de langage
- Toujours répondre en français
- Expliquer simplement, sans jargon inutile
- Je suis débutant — ne pas supposer que je connais quelque chose

### 2. PowerShell — Règle critique
- Toujours expliquer chaque ligne de script avant de le donner
- Jamais de script destructeur (suppression, modification en masse) sans confirmation explicite
- Toujours préciser si le script nécessite un module spécifique (RSAT, ActiveDirectory, etc.)
- Toujours indiquer si le script doit être testé en lab avant la production
- Format systématique :
  ```
  # Ce que fait ce script : [explication]
  # Prérequis : [modules, droits nécessaires]
  # Tester en lab d'abord : OUI/NON
  # LIGNE PAR LIGNE :
  # ligne 1 — explication
  # ligne 2 — explication
  [script]
  ```

### 3. KQL — Règle de documentation
- Chaque requête KQL doit inclure :
  - Le commentaire de description
  - La table source utilisée
  - Le mapping MITRE ATT&CK si applicable
  - Un exemple de résultat attendu
- Format :
  ```kql
  // Titre : [nom de la détection]
  // Description : [ce que ça détecte]
  // Table : [SecurityEvent / SigninLogs / etc.]
  // MITRE : [T1xxx — Nom de la technique] ou N/A
  // Résultat attendu : [exemple de ce qu'on voit]

  [requête KQL]
  ```

### 4. Structure des fichiers
Toujours respecter cette arborescence :
```
soc-quest/
├── AGENTS.md                    ← ce fichier
├── powershell/
│   ├── administration/          ← scripts admin Windows
│   ├── forensics/               ← scripts investigation SOC
│   └── lab-ad/                  ← scripts spécifiques au lab AD
├── kql/
│   ├── authentication/          ← détections connexions
│   ├── persistence/             ← détections persistance
│   ├── lateral-movement/        ← détections mouvement latéral
│   ├── exfiltration/            ← détections exfiltration
│   └── threat-hunting/          ← requêtes hunting avancées
├── lab-active-directory/
│   ├── setup/                   ← scripts installation AD
│   ├── gpo/                     ← configs GPO documentées
│   └── scenarios/               ← scénarios de support à pratiquer
├── sentinel-lab/
│   ├── analytics-rules/         ← règles d'analytics exportées
│   ├── playbooks/               ← Logic Apps documentées
│   └── screenshots/             ← preuves visuelles du lab
├── incident-writeups/           ← write-ups CyberDefenders/LetsDefend
└── notes/                       ← notes de cours par compétence
```

### 5. Commits Git
Quand tu crées ou modifies un fichier, suggère toujours un message de commit :
```
Format : [type] : [description courte]
Types : feat / fix / docs / lab / kql / ps1
Exemple : "kql: ajoute détection brute force T1110"
```

### 6. Avant d'exécuter quoi que ce soit
Toujours demander confirmation si l'action :
- Touche à des fichiers système
- Exécute un script réseau
- Modifie des configurations
- Crée des connexions externes

---

## Contexte technique

### Environnement lab
- Proxmox sur machine physique dédiée
- VMs disponibles : Windows Server 2022, Windows 10/11 clients
- Domaine AD cible : lab.local
- Réseau lab : 192.168.100.0/24

### Stack Microsoft
- M365 Business Premium (tenant réel)
- Intune déployé (en cours)
- Entra ID actif
- Defender for Endpoint actif

### Outils installés sur Mac
- Warp terminal
- PowerShell (brew install powershell)
- Git
- VS Code (optionnel)

---

## Phases du projet

### Phase 1 — ACTIVE (Mois 1-6)
Focus actuel : Active Directory, PowerShell, Wireshark, CompTIA A+/Network+
- Tout script PowerShell doit fonctionner sur Windows Server 2022
- Tester sur lab.local avant tout

### Phase 2 — VERROUILLÉE (Mois 6-18)
Windows Event Logs, Entra ID, MD-102, SC-900
- Déverrouillée quand A+ et Network+ sont validés

### Phase 3 — VERROUILLÉE (Mois 18-30)
Microsoft Sentinel, KQL, SC-200, Security+
- Déverrouillée quand MD-102 et SC-900 sont validés

### Phase 4 — VERROUILLÉE (Mois 30-42)
AZ-500, CySA+, CrowdStrike, Threat Hunting avancé
- Déverrouillée quand SC-200 est validé

---

## Triggers automatiques

Si je mentionne l'un de ces mots-clés, adopte le comportement correspondant :

| Mot-clé | Comportement |
|---|---|
| `powershell:` | Mode script PS1 — expliquer ligne par ligne |
| `kql:` | Mode requête KQL — documenter avec MITRE |
| `lab:` | Mode lab AD — commandes Windows Server 2022 |
| `sentinel:` | Mode Sentinel — tenant M365 Developer |
| `writeup:` | Mode write-up — format rapport d'incident SOC |
| `github:` | Mode portfolio — structure et README |
| `debug:` | Mode debug — analyser l'erreur étape par étape |
| `quiz:` | Mode quiz — poser 5 questions sur le sujet mentionné |

---

## Exemple de sessions types

### Session PowerShell
```
powershell: créer un script qui liste tous les utilisateurs AD
inactifs depuis 30 jours et exporte en CSV
```

### Session KQL
```
kql: écrire une règle qui détecte le Kerberoasting
```

### Session lab
```
lab: comment configurer une GPO qui bloque l'accès
aux paramètres système pour les utilisateurs standard
```

### Session quiz
```
quiz: windows event logs
→ Claude pose 5 questions sur les EventIDs critiques SOC
```

### Session write-up
```
writeup: j'ai complété le lab PsExec Hunt sur CyberDefenders,
voici mes notes [notes brutes]
→ Claude formate en write-up professionnel pour GitHub
```

---

## Ressources de référence rapide

### EventIDs critiques SOC
| ID | Signification |
|---|---|
| 4624 | Connexion réussie |
| 4625 | Connexion échouée |
| 4648 | Connexion avec credentials explicites |
| 4688 | Nouveau processus créé |
| 4720 | Compte utilisateur créé |
| 4732 | Utilisateur ajouté à groupe privilégié |
| 4740 | Compte verrouillé |
| 7045 | Nouveau service installé |
| 4698 | Tâche planifiée créée |

### MITRE ATT&CK — Techniques prioritaires
| ID | Technique |
|---|---|
| T1566 | Phishing |
| T1059.001 | PowerShell |
| T1053.005 | Scheduled Task |
| T1110 | Brute Force |
| T1550.002 | Pass the Hash |
| T1558.003 | Kerberoasting |
| T1003.001 | LSASS Dump |
| T1071.004 | DNS Tunneling |

### Liens rapides
- Microsoft Learn : https://learn.microsoft.com
- KQL Playground : https://dataexplorer.azure.com/clusters/help/databases/Samples
- MustLearnKQL : https://github.com/rod-trent/MustLearnKQL
- TryHackMe : https://tryhackme.com
- MITRE ATT&CK : https://attack.mitre.org
- Notion SOC Quest : [ajouter le lien de ta page Notion]
