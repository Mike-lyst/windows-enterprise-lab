# 🚨 Incident Report: CFO Cannot Access Finance Folder

##  Incident ID
INC-001

##  Date
2026-XX-XX

## 👤 Reported By
CFO (Executive User - user20)

---

##  Summary

The CFO reported inability to access the Finance folder required for reviewing critical financial documents.

---

##  Impact

- Executive operations blocked
- Financial review delayed
- Potential business decision risk

---

##  Initial Symptoms

- Access denied when opening Finance folder
- Other users unaffected
- No system-wide outage

---

## 🔍 Investigation

 Step 1: RBAC Validation

```text
user20 → Executive_Access → Finance → ALLOWED

Step 2: NTFS Permission Check
````
icacls C:\Dev\windows-enterprise-lab\EnterpriseData\Finance
```
Output received
Executive_Access:(DENY)(R)

Step 3: Root Cause
A misconfigured NTFS permission applied:

DENY rule assigned to Executive_Access
DENY overrides all ALLOW rules

Resolution

Removed the incorrect DENY rule:
````
icacls "C:\Dev\windows-enterprise-lab\EnterpriseData\Finance" /remove:d "Executive_Access"

Validation
CFO access restored
Test script confirmed alignment: