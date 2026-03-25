<#
.SYNOPSIS
    Remediates Windows 11 STIG WN11-AC-000010 by configuring account lockout threshold.

.DESCRIPTION
    This PowerShell script sets the account lockout threshold to 3 invalid logon attempts
    in accordance with Windows 11 STIG WN11-AC-000010.

.NOTES
    Author          : Nikhil Pawar
    LinkedIn        : https://www.linkedin.com/in/nikhil-pawar-535710178/
    GitHub          : https://github.com/nklpawar
    Date Created    : 2026-03-24
    Last Modified   : 2026-03-24
    Version         : 1.0
    STIG-ID         : WN11-AC-000010

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run in elevated PowerShell.

    Example:
    PS C:\> .\WN11-AC-000010.ps1
#>

try {
    net accounts /lockoutthreshold:3 | Out-Null

    $result = net accounts

    if ($result -match "Lockout threshold\s+3") {
        Write-Output "COMPLIANT: Account lockout threshold is set to 3."
    }
    else {
        Write-Output "NON-COMPLIANT: Unable to verify lockout threshold."
    }
}
catch {
    Write-Output "ERROR: Failed to remediate STIG WN11-AC-000010. $_"
}
