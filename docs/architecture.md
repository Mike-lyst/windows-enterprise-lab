# 🏗️ Windows Enterprise Lab Architecture

## 📌 Overview

This project simulates a real-world enterprise IT environment using:

- Role-Based Access Control (RBAC)
- NTFS Permissions
- PowerShell automation
- Incident-driven testing

The goal is to model how organizations manage access securely and troubleshoot failures.

---

## 🧩 Core Components

### 1. RBAC Layer (Logical Access Control)

Located in:
scripts/simulator/

Handles:
- User → Role mapping
- Role → Access decision

Example:

User → Role → Folder  
user13 → Sales_Team → Sales

---

### 2. NTFS Layer (Physical Access Control)

Located in:
C:\Dev\windows-enterprise-lab\EnterpriseData

Handles:
- Actual file system permissions
- Group-based access (IT_Team, Sales_Team, etc.)

---

### 3. Execution Layer

File:
scripts/simulator/run-lab.ps1

Responsibilities:
- Load RBAC system
- Run access tests
- Simulate real scenarios

---

### 4. Logging & Audit Layer

Located in:
scripts/reports/

Captures:
- Access granted/denied events
- Timestamped logs

---

### 5. Scenario Layer

Located in:
scenarios/

Includes:
- NTFS failures (deny override, inheritance issues)
- Enterprise incidents (CFO access failure)

---
``````
## 🔐 Access Model
User → Role → NTFS Group → Folder Access
Example:
user13 → Sales_Team → Sales_Team → Sales Folder
`````
---

## ⚙️ Design Principles

- Least Privilege
- Role-Based Access (No direct user permissions)
- Inheritance over manual overrides
- Audit logging for traceability

---

## 🚨 Failure Simulation Strategy

Each scenario follows:

1. Introduce misconfiguration
2. Observe failure
3. Identify root cause
4. Apply fix
5. Validate outcome

---

## 🧠 Key Insight

RBAC controls **who SHOULD have access**  
NTFS controls **who ACTUALLY has access**

Mismatch between both = real-world incidents

---

## 📈 Real-World Relevance

This architecture reflects:

- Enterprise IT environments
- Active Directory-based access control
- Security and compliance systems
- Incident response workflows