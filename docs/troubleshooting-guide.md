# 🛠️ Troubleshooting Guide

## 📌 Overview

This guide documents common issues encountered in the lab and how to resolve them.

---

## ❌ Issue 1: Script Not Found

### Error:
The term '.\rbac-engine.ps1' is not recognized

### Cause:
Incorrect file path or running script from wrong directory

### Fix:

Use dynamic path resolution:

```powershell
$base = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$base\rbac-engine.ps1"

