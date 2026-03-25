<#
.SYNOPSIS
    Remediates Windows 11 STIG WN11-00-000175 by disabling the Secondary Logon service.

.DESCRIPTION
    This PowerShell script ensures the Secondary Logon service (seclogon) is disabled
    in accordance with Windows 11 STIG WN11-00-000175. The script sets the startup type
    to Disabled and attempts to stop the service if it is running.

.NOTES
    Author          : Nikhil Pawar
    LinkedIn        : https://www.linkedin.com/in/nikhil-pawar-535710178/
    GitHub          : https://github.com/nklpawar
    Date Created    : 2026-03-24
    Last Modified   : 2026-03-24
    Version         : 1.0
    STIG-ID         : WN11-00-000175

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run in elevated PowerShell.

    Example:
    PS C:\> .\WN11-00-000175.ps1
#>

$serviceName = "seclogon"

try {
    Set-Service -Name $serviceName -StartupType Disabled -ErrorAction Stop

    try {
        $service = Get-Service -Name $serviceName -ErrorAction Stop
        if ($service.Status -ne "Stopped") {
            Stop-Service -Name $serviceName -Force -ErrorAction Stop
        }
    }
    catch {
        Write-Output "INFO: Secondary Logon service could not be stopped immediately. A reboot may be required."
    }

    $service = Get-CimInstance Win32_Service -Filter "Name='seclogon'"

    if ($service.StartMode -eq "Disabled") {
        Write-Output "COMPLIANT: Secondary Logon service startup type is Disabled."
    }
    else {
        Write-Output "NON-COMPLIANT: Secondary Logon service startup type is $($service.StartMode)."
    }
}
catch {
    Write-Output "ERROR: Failed to remediate STIG WN11-00-000175. $_"
}
