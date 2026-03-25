<#
.SYNOPSIS
    Remediates Windows 11 STIG WN11-CC-000038 by disabling WDigest authentication.

.DESCRIPTION
    This PowerShell script ensures WDigest authentication is disabled in accordance
    with Windows 11 STIG WN11-CC-000038. The script creates the required registry path
    if it does not already exist, sets UseLogonCredential to 0, and verifies the configuration.

.NOTES
    Author          : Nikhil Pawar
    LinkedIn        : https://www.linkedin.com/in/nikhil-pawar-535710178/
    GitHub          : https://github.com/nklpawar
    Date Created    : 2026-03-24
    Last Modified   : 2026-03-24
    Version         : 1.0
    STIG-ID         : WN11-CC-000038

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run in an elevated PowerShell session.

    Example:
    PS C:\> .\WN11-CC-000038.ps1
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest"
$valueName = "UseLogonCredential"
$desiredValue = 0

try {
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null

    $currentValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName

    if ($currentValue -eq $desiredValue) {
        Write-Output "COMPLIANT: WDigest UseLogonCredential is set to 0."
    }
    else {
        Write-Output "NON-COMPLIANT: WDigest UseLogonCredential is set to $currentValue."
    }
}
catch {
    Write-Output "ERROR: Failed to remediate STIG WN11-CC-000038. $_"
}
