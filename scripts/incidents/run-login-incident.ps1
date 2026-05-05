
Write-Output "🚀 Starting Multi-User Login Incident Simulation..."
Write-Output "-------------------------------------"

# -----------------------------
# PATHS
# -----------------------------
$simPath = "C:\Dev\windows-enterprise-lab\scripts\simulator"
$logPath = "C:\Dev\windows-enterprise-lab\scripts\reports\access-log.txt"

# Ensure log directory exists
$logDir = Split-Path $logPath
if (!(Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

# -----------------------------
# LOAD RBAC MODULES
# -----------------------------
. "$simPath\rbac-setup.ps1"
. "$simPath\rbac-engine.ps1"


# Account states
$global:LoginStatus = @{
    "user3" = "ACTIVE"
    "user5" = "DISABLED"
    "user8" = "ACTIVE"
    "user12" = "ACTIVE"
    "user17" = "ACTIVE"
}

# Service state
$global:ServiceStatus = @{
    "AuthService" = "STOPPED"
}

function Write-Log {
    param(
        [string]$User,
        [string]$Role,
        [string]$Status,
        [string]$Reason
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    "$timestamp | $Status | $User ($Role) | $Reason" |
    Out-File -FilePath $logPath -Append -Encoding utf8
}

# -----------------------------
# LOGIN ENGINE
# -----------------------------
function Test-Login {
    param(
        [string]$User
    )

    Write-Output "`n🔍 Login Attempt → $User"

    # User validation
    if (-not $global:RBAC.ContainsKey($User)) {
        Write-Output "❌ LOGIN FAILED → User not found"
        Write-Log $User "UNKNOWN" "FAILED" "User Not Found"
        return
    }

    $role = $global:RBAC[$User]

    # Account check
    if ($global:LoginStatus[$User] -eq "DISABLED") {
        Write-Output "❌ LOGIN FAILED → Account disabled"
        Write-Log $User $role "FAILED" "Account Disabled"
        return
    }

    # Service check
    if ($global:ServiceStatus["AuthService"] -ne "RUNNING") {
        Write-Output "❌ LOGIN FAILED → Auth service unavailable"
        Write-Log $User $role "FAILED" "Auth Service Down"
        return
    }

    # Success case
    Write-Output "✅ LOGIN SUCCESS → $User ($role)"
    Write-Log $User $role "SUCCESS" "Authentication Passed"
}

# ============================================
# INCIDENT FLOW
# ============================================

Write-Output "`n🧪 STEP 1: Initial system failure (AuthService down)"

Test-Login "user3"
Test-Login "user5"
Test-Login "user8"
Test-Login "user12"
Test-Login "user17"

Write-Output "`n🛠 STEP 2: Fix service (AuthService restarted)"
$global:ServiceStatus["AuthService"] = "RUNNING"

Write-Output "`n🧪 STEP 3: Retesting all users after service recovery"

Test-Login "user3"
Test-Login "user5"
Test-Login "user8"
Test-Login "user12"
Test-Login "user17"

Write-Output "`n🛠 STEP 4: Fix account issue for user2"
$global:LoginStatus["user5"] = "ACTIVE"

Write-Output "`n🧪 STEP 5: Final validation"

Test-Login "user3"
Test-Login "user5"
Test-Login "user8"
Test-Login "user12"
Test-Login "user17"

# -----------------------------
# INCIDENT SUMMARY
# -----------------------------
Write-Output "`n📊 INCIDENT SUMMARY"
Write-Output "Root Cause: AuthService outage + account misconfiguration"
Write-Output "Affected Users: user3, user5, user8, user12, user17(partial system failure)"
Write-Output "Resolution: Service restored + user5 account re-enabled"
Write-Output "System Status: Fully Operational"

# -----------------------------
# SHOW LOG OUTPUT
# -----------------------------
Write-Output "`n📄 Last 10 Log Entries"
Get-Content $logPath -Tail 10

Write-Output "`n✅ Incident simulation complete"