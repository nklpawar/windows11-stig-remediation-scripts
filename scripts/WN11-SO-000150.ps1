<#
.SYNOPSIS
    Remediates Windows 11 STIG WN11-SO-000150 by restricting anonymous enumeration of shares.

.DESCRIPTION
    This PowerShell script configures the system to prevent anonymous users from enumerating
    shares by setting RestrictAnonymous to 1 in accordance with Windows 11 STIG WN11-SO-000150.

.NOTES
    Author          : Nikhil Pawar
    LinkedIn        : https://www.linkedin.com/in/nikhil-pawar-535710178/
    GitHub          : https://github.com/nklpawar
    Date Created    : 2026-03-24
    Last Modified   : 2026-03-24
    Version         : 1.0
    STIG-ID         : WN11-SO-000150

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run in an elevated PowerShell session.

    Example:
    PS C:\> .\WN11-SO-000150.ps1
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "RestrictAnonymous"
$desiredValue = 1

try {
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null

    $currentValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName

    if ($currentValue -eq $desiredValue) {
        Write-Output "COMPLIANT: Anonymous share enumeration is restricted."
    }
    else {
        Write-Output "NON-COMPLIANT: RestrictAnonymous is set to $currentValue."
    }
}
catch {
    Write-Output "ERROR: Failed to remediate STIG WN11-SO-000150. $_"
}
