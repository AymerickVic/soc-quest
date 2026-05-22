<#
.SYNOPSIS
    Identifies stale Active Directory / Entra ID user accounts.

.DESCRIPTION
    Reports user accounts that have not logged in for a specified
    number of days. Useful for access reviews and reducing attack surface.

.PARAMETER DaysInactive
    Number of days without login to consider an account stale. Default: 90.

.PARAMETER ExportCsv
    Optional path to export results as CSV.

.EXAMPLE
    .\Get-StaleAccounts.ps1 -DaysInactive 90
    .\Get-StaleAccounts.ps1 -DaysInactive 60 -ExportCsv "C:\Reports\stale-accounts.csv"

.NOTES
    Author  : Aymerick Victoire
    Purpose : Access review, attack surface reduction
    Requires: ActiveDirectory module or AzureAD/Graph module
#>

param (
    [int]$DaysInactive = 90,
    [string]$ExportCsv = ""
)

$CutoffDate = (Get-Date).AddDays(-$DaysInactive)

Write-Host "[*] Searching for accounts inactive since $($CutoffDate.ToString('yyyy-MM-dd'))..." -ForegroundColor Cyan

try {
    Import-Module ActiveDirectory -ErrorAction Stop

    $StaleAccounts = Get-ADUser -Filter {
        LastLogonDate -lt $CutoffDate -and Enabled -eq $true
    } -Properties LastLogonDate, EmailAddress, Department, Manager |
    Select-Object `
        Name,
        SamAccountName,
        EmailAddress,
        Department,
        @{N="Manager"; E={ (Get-ADUser $_.Manager).Name }},
        @{N="LastLogon"; E={ $_.LastLogonDate }},
        @{N="DaysInactive"; E={ ((Get-Date) - $_.LastLogonDate).Days }}

    Write-Host "[+] Found $($StaleAccounts.Count) stale accounts" -ForegroundColor Yellow

    $StaleAccounts | Format-Table Name, SamAccountName, LastLogon, DaysInactive -AutoSize

    if ($ExportCsv) {
        $StaleAccounts | Export-Csv -Path $ExportCsv -NoTypeInformation -Encoding UTF8
        Write-Host "[+] Exported to $ExportCsv" -ForegroundColor Green
    }

} catch {
    Write-Warning "ActiveDirectory module not available. Install RSAT or run from a Domain Controller."
}
