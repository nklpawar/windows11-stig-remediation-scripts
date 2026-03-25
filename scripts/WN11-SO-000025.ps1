<#
.SYNOPSIS
    Remediates Windows 11 STIG WN11-SO-000025 by renaming the built-in Guest account.

.DESCRIPTION
    This PowerShell script locates the built-in Guest account by identifying the local
    account with a SID ending in -501, then renames it to a less obvious account name
    in accordance with Windows 11 STIG WN11-SO-000025.

.NOTES
    Author          : Nikhil Pawar
    LinkedIn        : https://www.linkedin.com/in/nikhil-pawar-535710178/
    GitHub          : https://github.com/nklpawar
    Date Created    : 2026-03-24
    Last Modified   : 2026-03-24
    Version         : 1.0
    STIG-ID         : WN11-SO-000025

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run in an elevated PowerShell session.

    Example:
    PS C:\> .\WN11-SO-000025.ps1

    To change the target name, modify the $newGuestName variable below.
#>

$newGuestName = "svc_guestbackup"

try {
    $guestAccount = Get-LocalUser | Where-Object { $_.SID.Value -match "-501$" }

    if (-not $guestAccount) {
        Write-Output "ERROR: Built-in Guest account with SID ending in -501 was not found."
        exit 1
    }

    $currentName = $guestAccount.Name

    if ($currentName -eq $newGuestName) {
        Write-Output "COMPLIANT: Built-in Guest account is already renamed to '$newGuestName'."
        exit 0
    }

    if (Get-LocalUser -Name $newGuestName -ErrorAction SilentlyContinue) {
        Write-Output "ERROR: An account named '$newGuestName' already exists. Choose a different name."
        exit 1
    }

    Rename-LocalUser -Name $currentName -NewName $newGuestName

    $renamedAccount = Get-LocalUser | Where-Object { $_.SID.Value -match "-501$" }

    if ($renamedAccount.Name -eq $newGuestName) {
        Write-Output "COMPLIANT: Built-in Guest account renamed from '$currentName' to '$newGuestName'."
    }
    else {
        Write-Output "NON-COMPLIANT: Built-in Guest account rename could not be verified."
    }
}
catch {
    Write-Output "ERROR: Failed to remediate STIG WN11-SO-000025. $_"
}
