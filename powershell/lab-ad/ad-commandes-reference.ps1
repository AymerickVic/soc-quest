# ============================================================
# ad-commandes-reference.ps1
# Référence des commandes PowerShell AD essentielles
#
# Auteur  : Aymerick Victoire
# Lab     : lab.local (DC01 — Azure)
# Usage   : Script de référence — adapter les valeurs avant exécution
# ============================================================

# ── USERS ──────────────────────────────────────────────────

# Lister tous les utilisateurs
Get-ADUser -Filter * | Select-Object Name, SamAccountName, Enabled

# Détails complets d'un utilisateur
Get-ADUser -Identity "t.martin" -Properties *

# Créer un utilisateur
New-ADUser -Name "Prenom Nom" `
    -GivenName      "Prenom" `
    -Surname        "Nom" `
    -SamAccountName "p.nom" `
    -UserPrincipalName "p.nom@lab.local" `
    -Path "OU=IT,DC=lab,DC=local" `
    -AccountPassword (ConvertTo-SecureString "MotDePasse#2024!" -AsPlainText -Force) `
    -Enabled $true

# Reset mot de passe
Set-ADAccountPassword -Identity "t.martin" `
    -NewPassword (ConvertTo-SecureString "NouveauMDP#2024!" -AsPlainText -Force) `
    -Reset

# Désactiver / Réactiver / Débloquer un compte
Disable-ADAccount -Identity "t.martin"
Enable-ADAccount  -Identity "t.martin"
Unlock-ADAccount  -Identity "t.martin"

# Trouver les comptes inactifs depuis 30 jours
$date = (Get-Date).AddDays(-30)
Get-ADUser -Filter {LastLogonDate -lt $date -and Enabled -eq $true} `
    -Properties LastLogonDate | Select-Object Name, SamAccountName, LastLogonDate


# ── GROUPES ────────────────────────────────────────────────

# Lister tous les groupes
Get-ADGroup -Filter * | Select-Object Name, GroupScope, GroupCategory

# Voir les membres d'un groupe
Get-ADGroupMember -Identity "GRP_IT" | Select-Object Name, SamAccountName

# Voir tous les groupes d'un utilisateur
Get-ADPrincipalGroupMembership -Identity "t.martin" | Select-Object Name

# Ajouter un utilisateur à un groupe
Add-ADGroupMember -Identity "GRP_IT" -Members "t.martin"

# Retirer un utilisateur d'un groupe
Remove-ADGroupMember -Identity "GRP_IT" -Members "t.martin" -Confirm:$false


# ── OUs ────────────────────────────────────────────────────

# Lister toutes les OUs
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName

# Créer une OU
New-ADOrganizationalUnit -Name "NomOU" -Path "DC=lab,DC=local"


# ── COMPUTERS ──────────────────────────────────────────────

# Lister tous les ordinateurs du domaine
Get-ADComputer -Filter * | Select-Object Name, DNSHostName, DistinguishedName


# ── GPO ────────────────────────────────────────────────────

# Lister toutes les GPOs
Get-GPO -All | Select-Object DisplayName, GpoStatus

# Créer et lier une GPO
New-GPO -Name "GPO_Exemple" -Comment "Description"
New-GPLink -Name "GPO_Exemple" -Target "OU=IT,DC=lab,DC=local"
