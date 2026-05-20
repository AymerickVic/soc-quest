# ============================================================
# import-users-csv.ps1
# Création en masse d'utilisateurs AD depuis un fichier CSV
#
# Auteur  : Aymerick Victoire
# Lab     : lab.local (DC01 — Azure)
# Usage   : Importer un CSV avec colonnes Prenom, Nom, Departement
# ============================================================

# --- Format attendu du CSV ---
# Prenom,Nom,Departement
# Alice,Bernard,IT
# Bob,Carrier,RH

param (
    [string]$CsvPath = "C:\users_import.csv",
    [string]$DefaultPassword = "Bienvenue#2024!"
)

Import-Csv $CsvPath | ForEach-Object {

    $prenom = $_.Prenom
    $nom    = $_.Nom
    $dept   = $_.Departement
    $login  = ($prenom[0] + "." + $nom).ToLower()
    $upn    = "$login@lab.local"
    $ou     = "OU=$dept,DC=lab,DC=local"

    try {
        New-ADUser `
            -Name              "$prenom $nom" `
            -GivenName         $prenom `
            -Surname           $nom `
            -SamAccountName    $login `
            -UserPrincipalName $upn `
            -Path              $ou `
            -AccountPassword   (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force) `
            -Enabled           $true

        Write-Host "[OK] Cree : $login → $ou" -ForegroundColor Green
    }
    catch {
        Write-Host "[ERREUR] $login : $($_.Exception.Message)" -ForegroundColor Red
    }
}
