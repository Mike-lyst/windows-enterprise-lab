Write-Output "🔐 Initializing RBAC..."
$global:RBAC = @{}

# IT (user1–user3)
1..3 | ForEach-Object { $global:RBAC["user$_"] = "IT_Team" }

# Engineering (user4–user8)
4..8 | ForEach-Object { $global:RBAC["user$_"] = "Engineering_Team" }

# Quality 
9..12 | ForEach-Object { $global:RBAC["user$_"] = "Quality_Team" }

# Sales (user13–user16)
13..16 | ForEach-Object { $global:RBAC["user$_"] = "Sales_Team" }

# Finance (user17–user19)
17..19 | ForEach-Object { $global:RBAC["user$_"] = "Finance_Team" }

# Executive
$global:RBAC["user20"] = "Executive_Access"

Write-Output "✅ RBAC mapping loaded"

Write-Output "`n📊 RBAC Summary:"
$global:RBAC.GetEnumerator() | Sort-Object Key | ForEach-Object {
    Write-Output "$($_.Key) → $($_.Value)"
}
# -----------------------------
# 🔐 LOGIN STATE SIMULATION
# -----------------------------
$global:LoginStatus = @{
    "user5" = "DISABLED"   # simulate failure
}
# -------------------------------

$global:AccessMatrix = @{
    "IT_Team"         = @("IT", "Engineering", "Finance", "Logs")
    "Engineering_Team"= @("Engineering")
    "Quality_Team"    = @("Quality", "Engineering")
    "Sales_Team"      = @("Sales", "Finance")
    "Finance_Team"    = @("Finance")
    "Executive_Access"= @("IT", "Engineering", "Finance", "Sales", "Quality", "Executive")
}


$global:Users = 1..20 | ForEach-Object { "user$_" }

$global:LogPath = "C:\Dev\windows-enterprise-lab\scripts\reports\access-log.txt"

$logDir = Split-Path $global:LogPath
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

if (-not (Test-Path $global:LogPath)) {
    New-Item -ItemType File -Path $global:LogPath -Force | Out-Null
}

Write-Output "📁 Logging ready at $global:LogPath"

Write-Output "`n🔧 Applying RBAC to Local Groups..."

foreach ($user in $global:RBAC.Keys) {

    $group = $global:RBAC[$user]

    try {
        # Get actual local user object
        $localUser = Get-LocalUser -Name $user -ErrorAction SilentlyContinue

        if (-not $localUser) {
            Write-Output "❌ User not found: $user"
            continue
        }

        # Get group members safely
        $members = Get-LocalGroupMember -Group $group -ErrorAction SilentlyContinue

        # Normalize names for comparison
        $memberNames = $members | ForEach-Object { $_.Name -replace ".*\\", "" }

        if ($memberNames -notcontains $user) {
            Add-LocalGroupMember -Group $group -Member $localUser -ErrorAction Stop
            Write-Output "✔ Added $user to $group"
        }
        else {
            Write-Output "ℹ $user already in $group"
        }
    }
    catch {
        Write-Output "❌ Failed to add $user to $group - $($_.Exception.Message)"
    }
}
    