# 🚨 Login Failure Incident — Service Dependency Breakdown

## 🧪 Scenario

A user was unable to log in to the system.

- User: user5
- Role: Engineering_Team
- Expected: Login SUCCESS

But authentication failed.

Password was correct.  
Access roles were correctly assigned.

Yet login still failed.

---

## 🔍 Investigation

Using my Windows Enterprise Lab test engine:

Test executed:
Test-Login "user5"

Initial output:
❌ LOGIN FAILED

---

## 🧠 Layered Troubleshooting Approach

Instead of guessing, I broke it down:

### 1. Identity Layer
✔ User exists in system

### 2. Account Layer
✔ Account is active (not disabled)

### 3. Authentication Layer
❌ Authentication service was DOWN

### 4. System Logs
✔ Logs confirmed authentication failure

---

## 🚨 Root Cause

The issue was not credentials.

It was a **service dependency failure**:

→ Authentication service was not running

Even though everything else was correct, the system could not validate login requests.

---

## 🛠️ Fix Applied

Restarted authentication service in simulation:

$global:ServiceStatus["AuthService"] = "RUNNING"

Re-tested login:

Test-Login "user5"

Result:
✅ LOGIN SUCCESS

---

## 💡 Key Lessons

- Login failures are rarely caused by passwords
- Services are critical hidden dependencies in authentication systems
- Troubleshooting must follow layers, not assumptions:

Identity → Account → Authentication Service → Logs → System Access

- One failed service can break the entire login flow



![alt text](<Screenshot 2026-05-05 140601.png>)
![alt text](<Screenshot 2026-05-05 140740.png>)