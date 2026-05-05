
---

# 📁 3. `access-denied-sales-engineering.md`

```markdown
# Incident: Sales Cannot Access Engineering

## 📌 Description
A Sales team user is unable to access the Engineering folder.

---

## 🧪 Scenario

User:
user13 (Sales_Team)

Target:
C:\EnterpriseData\Engineering

---

## ❌ Observed Behavior

ACCESS DENIED

---

## 🔍 Root Cause

An explicit deny rule was configured:

```powershell
icacls "C:\EnterpriseData\Engineering" /deny "Sales_Team:(R)"