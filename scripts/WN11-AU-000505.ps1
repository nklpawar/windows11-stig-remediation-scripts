<#
.SYNOPSIS
    Remediates Windows 11 STIG WN11-AU-000505 by configuring the Security event log maximum size to 1024000 KB or greater.

.DESCRIPTION
    This PowerShell script ensures the Security event log is configured in accordance with
    Windows 11 STIG WN11-AU-000505. The script creates the required registry path if it does
    not already exist, sets the MaxSize value to 1024000 KB, and verifies the configuration.

.NOTES
    Author          : Nikhil Pawar
    LinkedIn        : https://www.linkedin.com/in/nikhil-pawar-535710178/
    GitHub          : https://github.com/nklpawar
    Date Created    : 2026-03-24
    Last Modified   : 2026-03-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000505

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run this script in an elevated PowerShell session.

    Example:
    PS C:\> .\WN11-AU-000505.ps1
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$valueName = "MaxSize"
$desiredValue = 1024000

try {
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null

    $currentValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName

    if ($currentValue -ge $desiredValue) {
        Write-Output "COMPLIANT: Security log size is set to $currentValue KB"
    }
    else {
        Write-Output "NON-COMPLIANT: Security log size is set to $currentValue KB"
    }
}
catch {
    Write-Output "ERROR: Failed to apply remediation for STIG WN11-AU-000505. $_"
}
