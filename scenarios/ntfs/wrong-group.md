@'
# Scenario: Wrong Group Assignment

## 📌 Description
A user is unable to access the correct department folder due to being assigned to the wrong group.

---

## 🧪 Simulation

User:
user13

Expected Role:
Sales_Team

Actual Issue:
User was mistakenly assigned to Engineering_Team

---

## ❌ Observed Behavior

User attempts to access:
C:Dev\windows-enterprise-lab\EnterpriseData\Sales

Result:
ACCESS DENIED

---

## 🔍 Root Cause

RBAC mapping error — user assigned to incorrect group.

This caused:
- Access mismatch
- Violation of least privilege principle

---

## 🛠️ Fix

Correct the RBAC mapping:

```powershell
$RBAC["user13"] = "Sales_Team"