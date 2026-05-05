

```markdown
# Incident: CFO Cannot Access Finance Folder

## 📌 Description
The CFO is unable to access the Finance department folder, causing a critical business disruption.

---

## 🧪 Scenario

User:
user20 (Executive_Access)

Target:
C:\EnterpriseData\Finance

---

## ❌ Observed Behavior

ACCESS DENIED

---

## 🔍 Root Cause

RBAC misconfiguration:

User was assigned:
Executive_Access

But the role did not include:
Finance folder access

---

## 🛠️ Fix

Update RBAC mapping:

```powershell
$AccessMatrix["Executive_Access"] += "Finance"