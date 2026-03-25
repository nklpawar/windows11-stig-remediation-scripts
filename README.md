## Windows 11 STIG Remediation Scripts

This repository contains PowerShell scripts designed to remediate selected Windows 11 Security Technical Implementation Guide (STIG) findings.

Each script:
- Targets a specific STIG control
- Applies the required configuration using PowerShell
- Verifies the applied setting where applicable

The goal of this project is to demonstrate hands-on experience with:
- Windows security hardening
- Registry and policy configuration
- Service and account management
- Automation of compliance remediation

---

## Script Overview

| STIG ID | Script | Description |
|--------|--------|------------|
| WN11-AU-000500 | [WN11-AU-000500.ps1](scripts/WN11-AU-000500.ps1) | Configures Application event log size to a minimum of 32768 KB |
| WN11-AU-000505 | [WN11-AU-000505.ps1](scripts/WN11-AU-000505.ps1) | Configures Security event log size to a minimum of 1024000 KB |
| WN11-AU-000510 | [WN11-AU-000510.ps1](scripts/WN11-AU-000510.ps1) | Configures System event log size to a minimum of 32768 KB |
| WN11-00-000175 | [WN11-00-000175.ps1](scripts/WN11-00-000175.ps1) | Disables the Secondary Logon service |
| WN11-CC-000038 | [WN11-CC-000038.ps1](scripts/WN11-CC-000038.ps1) | Disables WDigest authentication to prevent credential exposure |
| WN11-CC-000190 | [WN11-CC-000190.ps1](scripts/WN11-CC-000190.ps1) | Disables Autoplay for all drives to reduce malware risk |
| WN11-SO-000025 | [WN11-SO-000025.ps1](scripts/WN11-SO-000025.ps1) | Renames the built-in Guest account to reduce attack surface |
| WN11-SO-000070 | [WN11-SO-000070.ps1](scripts/WN11-SO-000070.ps1) | Configures machine inactivity timeout (auto-lock after 15 minutes) |
| WN11-SO-000150 | [WN11-SO-000150.ps1](scripts/WN11-SO-000150.ps1) | Restricts anonymous enumeration of shares |
| WN11-AC-000010 | [WN11-AC-000010.ps1](scripts/WN11-AC-000010.ps1) | Configures account lockout threshold to 3 failed attempts |

---

## How to Use

Run scripts in an elevated PowerShell session:

    cd scripts
    .\WN11-AU-000500.ps1

---

## Notes

- Scripts are designed for standalone testing in a Windows 11 environment
- Some changes may require logoff or system restart to fully apply
- Verification is performed using:
  - Registry checks
  - Local security policy
  - Service configuration
