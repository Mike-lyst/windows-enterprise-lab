 Domain Login Failure — Group Policy Misconfiguration

 Scenario

A user was unable to log in to a domain-connected system.

- User: user17
- Role: Finance_Team
- Expected: Login SUCCESS

But login failed at the domain level.

Credentials were correct.  
Account was active.  

Still, access was denied.

 Investigation

Test executed:

Test-Login "user17"

Initial output:
❌ LOGIN FAILED

---

##  Layered Troubleshooting Approach

### 1. Identity Layer
✔ User exists in Active Directory

### 2. Account Layer
✔ Account is enabled  
✔ Not locked or expired  

### 3. Service Layer
✔ Authentication services running  

### 4. Policy Layer (Critical)
❌ Group Policy restriction detected

### 5. Logs
✔ Login denied due to policy restriction

---

## Root Cause

A Group Policy Object (GPO) restricted login for the Finance_Team group.

→ “Deny log on locally” policy was applied

Even with correct credentials and active account,  
the system blocked access based on policy rules.

---

 Fix Applied

Updated Group Policy simulation:

$global:GPO["DenyLogon"] = @()

Re-tested login:

Test-Login "user17"

Result:
✅ LOGIN SUCCESS

---

## 💡 Key Lessons

- Authentication success does not guarantee login success
- Group Policy can override user access at the system level
- Access control includes policy enforcement, not just permissions

Layered model:

Identity → Account → Services → Group Policy → System Access

- Policies operate silently but have full control

