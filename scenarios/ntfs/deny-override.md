# Scenario: Deny Overrides Allow

## 📌 Description
A user in the Sales team cannot access the Engineering folder, despite having expected access permissions.

---

## 🧪 Simulation

User:
user13 (Sales_Team)

Target Folder:
"C:\Dev\windows-enterprise-lab\EnterpriseData\Engineering"
---

## ❌ Observed Behavior

Result:
ACCESS DENIED

---

## 🔍 Root Cause

An explicit **DENY** permission was applied to the Sales_Team on the Engineering folder.

In NTFS:
> DENY always overrides ALLOW

Even if:
- The user belongs to another group with access
- Permissions appear correctly configured

---

##  Fix

Remove the deny rule:

```powershell
icacls "C:\EnterpriseData\Engineering" /remove:d "Sales_Team"