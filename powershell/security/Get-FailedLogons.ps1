<#
.SYNOPSIS
    Extracts and summarizes failed logon events from Windows Security Log.

.DESCRIPTION
    Queries EventID 4625 from the Security event log and produces
    a summary grouped by account and source IP. Useful for detecting
    brute force attempts on a local machine.

.PARAMETER Hours
    How many hours back to search. Default: 24.

.PARAMETER Threshold
    Minimum number of failures to include in output. Default: 3.

.EXAMPLE
    .\Get-FailedLogons.ps1 -Hours 24 -Threshold 5

.NOTES
    Author  : Aymerick Victoire
    Requires: Administrator privileges to read Security log
#>

param (
    [int]$Hours = 24,
    [int]$Threshold = 3
)

Write-Host "[*] Querying failed logons from the last $Hours hours..." -ForegroundColor Cyan

$StartTime = (Get-Date).AddHours(-$Hours)

$Events = Get-WinEvent -FilterHashtable @{
    LogName   = "Security"
    Id        = 4625
    StartTime = $StartTime
} -ErrorAction SilentlyContinue

if (-not $Events) {
    Write-Warning "No failed logon events found. Run as Administrator."
    exit
}

Write-Host "[+] Found $($Events.Count) failed logon events" -ForegroundColor Yellow

$Summary = $Events | ForEach-Object {
    $xml = [xml]$_.ToXml()
    $data = $xml.Event.EventData.Data
    [PSCustomObject]@{
        TimeCreated  = $_.TimeCreated
        TargetAccount = ($data | Where-Object { $_.Name -eq "TargetUserName" }).'#text'
        SourceIP      = ($data | Where-Object { $_.Name -eq "IpAddress" }).'#text'
        LogonType     = ($data | Where-Object { $_.Name -eq "LogonType" }).'#text'
        WorkStation   = ($data | Where-Object { $_.Name -eq "WorkstationName" }).'#text'
    }
} |
Group-Object TargetAccount, SourceIP |
Where-Object { $_.Count -ge $Threshold } |
Select-Object `
    @{N="Account";      E={ $_.Name.Split(",")[0].Trim() }},
    @{N="SourceIP";     E={ $_.Name.Split(",")[1].Trim() }},
    @{N="FailureCount"; E={ $_.Count }},
    @{N="FirstSeen";    E={ ($_.Group | Sort TimeCreated | Select -First 1).TimeCreated }},
    @{N="LastSeen";     E={ ($_.Group | Sort TimeCreated | Select -Last 1).TimeCreated }} |
Sort-Object FailureCount -Descending

$Summary | Format-Table -AutoSize
Write-Host "[!] Accounts with $Threshold+ failures: $($Summary.Count)" -ForegroundColor Red
