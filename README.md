# 🏢 Windows Enterprise Lab (RBAC + NTFS + Incident Simulation)

This project simulates a real-world enterprise environment using PowerShell.

It is designed to demonstrate how access control, RBAC (Role-Based Access Control), and NTFS permissions behave in production systems — including common failures and how to troubleshoot them.

---

## 🚀 What This Project Covers

- 🔐 RBAC (Role-Based Access Control) design
- 📁 NTFS permission management
- ⚠️ Real-world failure scenarios (Access Denied, broken inheritance)
- 🛠️ Incident troubleshooting workflow
- 🧠 System-level thinking (not just commands)


---

## ⚙️ How It Works

### 1. Setup Environment

Creates a safe lab directory:

C:\Dev\windows-enterprise-lab\EnterpriseData

---

### 2. RBAC System

Users are mapped to roles:

- IT_Team
- Engineering_Team
- Quality_Team 
- Sales_Team
- Finance_Team
- Executive_Access

---

### 3. Access Engine

Simulates enterprise access logic:
User → Role → Folder Access Decision

---

### 4. Failure Simulation

Examples included:

- ❌ Sales cannot access Engineering
- ❌ Broken inheritance
- ❌ Wrong group assignment
- ❌ CFO cannot access Finance

---

### 5. Troubleshooting

Each issue is:

- Reproduced
- Diagnosed
- Fixed
- Validated

---

## ▶️ Run the Lab

Open PowerShell in VS Code:

```powershell
cd C:\Dev\windows-enterprise-lab
 .\scripts\simulator\run-lab.ps1
````````
--------------------------------------

✅ ACCESS GRANTED → user1 (IT_Team) → IT
✅ ACCESS GRANTED → user5 (Engineering_Team) → Engineering
❌ ACCESS DENIED → user13 (Sales_Team) → Engineering
✅ ACCESS GRANTED → user17 (Finance_Team) → Finance
✅ ACCESS GRANTED → user20 (Executive_Access) → Finance
-------------------------------------
✅ Lab complete

Key Concepts Demonstrated
Least privilege access
Deny overrides Allow (NTFS)
RBAC vs direct permission assignment
Separation of concerns (setup vs logic vs execution)
Incident-based troubleshooting

Safety Note

All scripts are designed to run inside:

C:\Dev\windows-enterprise-lab
📌 Why This Project Matters

Most beginners:
 Run commands
 Memorize syntax

This project shows:

 How systems are designed
 How failures happen
 How engineers debug real issues

 Author
Okwuora Michael

Built as part of a hands-on journey into:

Cloud Engineering
DevOps
System Administration
Security & Access Control