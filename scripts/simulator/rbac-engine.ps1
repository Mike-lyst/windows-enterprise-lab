Write-Output "⚙️ Loading RBAC Engine..."

$AccessMatrix = @{
    "IT_Team"          = @("IT","Engineering","Quality","Sales","Finance")
    "Engineering_Team" = @("Engineering")
    "Quality_Team"     = @("Quality")
    "Sales_Team"       = @("Sales")
    "Finance_Team"     = @("Finance")
    "Executive_Access" = @("Finance","IT","Engineering")
}

$NTFS = @{
    "IT"          = @("IT_Team")
    "Engineering" = @("Engineering_Team")
    "Quality"     = @("Quality_Team")
    "Sales"       = @("Sales_Team")
    "Finance"     = @("Finance_Team")
}
$logPath = "C:\Dev\windows-enterprise-lab\scripts\reports\access-log.txt"
function Write-Log {
    param($Message)

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -Append -FilePath $logPath
}
function Test-Access {
    param(
        [string]$User,
        [string]$Folder
    )

    # Validate user
    if (-not $global:RBAC.ContainsKey($User)) {
        $msg = "❌ Unknown user → $User"
        Write-Output $msg
        Write-Log $msg
        return
    }

    $role = $global:RBAC[$User].Trim()
    $folderClean = $Folder.Trim()

    # Validate role exists in RBAC model
    if (-not $AccessMatrix.ContainsKey($role)) {
        $msg = "❌ Unknown role → $role"
        Write-Output $msg
        Write-Log $msg
        return
    }

    # -----------------------------
    # RBAC CHECK
    # -----------------------------
    $rbacAllowed = $AccessMatrix[$role] -contains $folderClean

    # -----------------------------
    # NTFS CHECK (NEW LOGIC)
    # -----------------------------
    if (-not $NTFS.ContainsKey($folderClean)) {
        $ntfsAllowed = $false
    } else {
        $ntfsAllowed = $NTFS[$folderClean] -contains $role
    }

    # -----------------------------
    # FINAL DECISION
    # -----------------------------
    if ($rbacAllowed -and $ntfsAllowed) {
        $result = "ACCESS GRANTED → $User ($role) → $folderClean"
    }
    elseif (-not $rbacAllowed -and $ntfsAllowed) {
        $result = "ACCESS DENIED (RBAC BLOCKED) → $User ($role) → $folderClean"
    }
    elseif ($rbacAllowed -and -not $ntfsAllowed) {
        $result = "ACCESS DENIED (NTFS BLOCKED) → $User ($role) → $folderClean"
    }
    else {
        $result = "ACCESS DENIED → $User ($role) → $folderClean"
    }

    Write-Output $result
    Write-Log $result
}