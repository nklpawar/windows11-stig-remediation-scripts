<#
.SYNOPSIS
    Remediates Windows 11 STIG WN11-SO-000070 by configuring machine inactivity lock timeout.

.DESCRIPTION
    This PowerShell script sets the machine inactivity limit to 900 seconds (15 minutes)
    in accordance with Windows 11 STIG WN11-SO-000070 by configuring the registry value.

.NOTES
    Author          : Nikhil Pawar
    LinkedIn        : https://www.linkedin.com/in/nikhil-pawar-535710178/
    GitHub          : https://github.com/nklpawar
    Date Created    : 2026-03-24
    Last Modified   : 2026-03-24
    Version         : 1.0
    STIG-ID         : WN11-SO-000070

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run in an elevated PowerShell session.

    Example:
    PS C:\> .\WN11-SO-000070.ps1
#>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "InactivityTimeoutSecs"
$desiredValue = 900

try {
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null

    $currentValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName

    if ($currentValue -eq $desiredValue) {
        Write-Output "COMPLIANT: Inactivity timeout is set to 900 seconds (15 minutes)."
    }
    else {
        Write-Output "NON-COMPLIANT: Inactivity timeout is set to $currentValue seconds."
    }
}
catch {
    Write-Output "ERROR: Failed to remediate STIG WN11-SO-000070. $_"
}
