<#
.SYNOPSIS
    Remediates Windows 11 STIG WN11-CC-000190 by disabling Autoplay for all drives.

.DESCRIPTION
    This PowerShell script disables Autoplay functionality for all drives in accordance
    with Windows 11 STIG WN11-CC-000190 by setting NoDriveTypeAutoRun to 255.

.NOTES
    Author          : Nikhil Pawar
    LinkedIn        : https://www.linkedin.com/in/nikhil-pawar-535710178/
    GitHub          : https://github.com/nklpawar
    Date Created    : 2026-03-24
    Last Modified   : 2026-03-24
    Version         : 1.0
    STIG-ID         : WN11-CC-000190

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run in an elevated PowerShell session.

    Example:
    PS C:\> .\WN11-CC-000190.ps1
#>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valueName = "NoDriveTypeAutoRun"
$desiredValue = 255

try {
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null

    $currentValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName

    if ($currentValue -eq $desiredValue) {
        Write-Output "COMPLIANT: Autoplay is disabled for all drives."
    }
    else {
        Write-Output "NON-COMPLIANT: Autoplay value is $currentValue."
    }
}
catch {
    Write-Output "ERROR: Failed to remediate STIG WN11-CC-000190. $_"
}
