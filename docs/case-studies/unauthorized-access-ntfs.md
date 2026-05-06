@'
# 🚨 Unauthorized Access Incident — RBAC vs NTFS Mismatch

## 🧪 Scenario

A user accessed a restricted Finance folder despite not having permission.

- User: user13
- Role: Sales_Team
- Target: Finance folder

According to RBAC:
→ Access should be DENIED

---

## 🔍 Investigation

Using the PowerShell test engine:

Test executed:
Test-FullAccess "user13" "Finance"

Output:
user13 (Sales_Team) → Finance | RBAC: DENY | NTFS: ALLOW
🚨 CRITICAL: RBAC denies but NTFS allows!

---

## 🧠 Root Cause

The NTFS layer included a broad permission:

→ Simulated “Authenticated Users”

This unintentionally allowed access to users outside the intended role.

---

## 🛠️ Fix Applied

Removed broad access from NTFS policy:

$NTFS["Finance"] = @("Finance_Team")

---

## ✅ Validation

Re-tested access:

RBAC: DENY  
NTFS: DENY  

Access correctly blocked.

---

## 💡 Key Lessons

- RBAC defines intent, but NTFS enforces access
- Broad permissions can silently override security design
- Access control must be validated across all layers

---

## 📸 Evidence

(Add screenshots here)
- Mismatch output (RBAC DENY / NTFS ALLOW)
- Fixed output (RBAC DENY / NTFS DENY)
'@ | Set-Content .\docs\case-studies\unauthorized-access-ntfs.md