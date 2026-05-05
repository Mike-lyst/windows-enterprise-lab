
---

# 📁 2. `broken-inheritance.md`

```markdown
# Scenario: Broken Inheritance

## 📌 Description
Users experience inconsistent access across folders due to inheritance being disabled.

---

## 🧪 Simulation

Action:
Inheritance was disabled at the root folder:

C:Dev\windows-enterprise-lab\EnterpriseData

---

## ❌ Observed Behavior

- Some folders are accessible
- Others return ACCESS DENIED
- Permissions appear inconsistent

---

## 🔍 Root Cause

Inheritance was disabled using:

```powershell
icacls C:Dev\windows-enterprise-lab\EnterpriseData /inheritance:d