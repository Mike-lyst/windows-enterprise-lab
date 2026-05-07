# ============================================
# WINDOWS ENTERPRISE LAB
# GROUP POLICY LOGIN INCIDENT
# ============================================

Write-Output "🚀 Starting Group Policy Login Incident..."
Write-Output "-------------------------------------------"

# ============================================
# LOGGING SETUP
# ============================================

$logDir = "C:\Dev\windows-enterprise-lab\scripts\reports"
$logPath = "$logDir\gpo-incident-log.txt"

# Ensure log directory exists
if (!(Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

# Ensure log file exists
if (!(Test-Path $logPath)) {
    New-Item -ItemType File -Path $logPath -Force | Out-Null
}

# ============================================
# LOAD RBAC + ENGINE
# ============================================

$simPath = "C:\Dev\windows-enterprise-lab\scripts\simulator"

. "$simPath\rbac-setup.ps1"

# ============================================
# LOG FUNCTION
# ============================================

function Write-Log {

    param($Message)

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    "$timestamp | $Message" | Out-File -Append -FilePath $logPath
}

# ============================================
# SERVICE STATUS
# ============================================

$global:ServiceStatus = @{
    "AuthService" = "RUNNING"
}

# ============================================
# ACCOUNT STATUS
# ============================================

$global:DisabledAccounts = @()

# ============================================
# GROUP POLICY SIMULATION
# ============================================

$global:GPO = @{
    "DenyLogon" = @("Finance_Team")
}

# ============================================
# LOGIN TEST FUNCTION
# ============================================

function Test-Login {

    param($User)

    Write-Output ""
    Write-Output "🔍 Login Attempt → $User"

    # -----------------------------
    # USER CHECK
    # -----------------------------

    if (-not $global:RBAC.ContainsKey($User)) {

        Write-Output "❌ LOGIN FAILED → Unknown user"

        Write-Log "FAILED | $User | Unknown user"

        return
    }

    $role = $global:RBAC[$User]

    # -----------------------------
    # ACCOUNT CHECK
    # -----------------------------

    if ($global:DisabledAccounts -contains $User) {

        Write-Output "❌ LOGIN FAILED → Account disabled"

        Write-Log "FAILED | $User ($role) | Account disabled"

        return
    }

    # -----------------------------
    # SERVICE CHECK
    # -----------------------------

    if ($global:ServiceStatus["AuthService"] -ne "RUNNING") {

        Write-Output "❌ LOGIN FAILED → Authentication service unavailable"

        Write-Log "FAILED | $User ($role) | AuthService down"

        return
    }

    # -----------------------------
    # GPO CHECK
    # -----------------------------

    if ($global:GPO["DenyLogon"] -contains $role) {

        Write-Output "❌ LOGIN FAILED → GPO restriction"

        Write-Log "FAILED | $User ($role) | Blocked by Group Policy"

        return
    }

    # -----------------------------
    # SUCCESS
    # -----------------------------

    Write-Output "✅ LOGIN SUCCESS → $User ($role)"

    Write-Log "SUCCESS | $User ($role) | Login successful"
}

# ============================================
# INCIDENT START
# ============================================

Write-Output ""
Write-Output "🧪 STEP 1: Initial Login Validation"
Write-Output ""

Test-Login "user3"
Test-Login "user5"
Test-Login "user17"

# ============================================
# INCIDENT DETECTED
# ============================================

Write-Output ""
Write-Output "🚨 INCIDENT DETECTED"
Write-Output "Finance users unable to log in"
Write-Output ""

# ============================================
# INVESTIGATION
# ============================================

Write-Output "🔍 STEP 2: Investigating Policy Layer..."
Write-Output ""

Write-Output "Detected:"
Write-Output "→ DenyLogon policy applied to Finance_Team"

Write-Log "INVESTIGATION | GPO restriction detected on Finance_Team"

# ============================================
# FIX APPLIED
# ============================================

Write-Output ""
Write-Output "🛠 STEP 3: Removing GPO Restriction..."
Write-Output ""

$global:GPO["DenyLogon"] = @()

Write-Log "FIX APPLIED | DenyLogon policy removed"

# ============================================
# RETEST
# ============================================

Write-Output ""
Write-Output "🧪 STEP 4: Retesting Login Access"
Write-Output ""

Test-Login "user17"

# ============================================
# FINAL SUMMARY
# ============================================

Write-Output ""
Write-Output "📊 INCIDENT SUMMARY"
Write-Output "-------------------------------------------"

Write-Output "Incident Type: Group Policy Login Restriction"
Write-Output "Affected Group: Finance_Team"
Write-Output "Root Cause: DenyLogon policy misconfiguration"
Write-Output "Resolution: GPO restriction removed"
Write-Output "System Status: Fully Operational"

Write-Log "INCIDENT RESOLVED | Finance_Team login restored"

# ============================================
# LAST LOGS
# ============================================

Write-Output ""
Write-Output "📄 Last 10 Log Entries"
Write-Output "-------------------------------------------"

Get-Content $logPath -Tail 10

Write-Output ""
Write-Output "✅ Group Policy incident simulation complete"