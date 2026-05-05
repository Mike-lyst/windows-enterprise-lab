Write-Output "🔐 Creating real local groups..."

$groups = @(
    "IT_Team",
    "Engineering_Team",
    "Quality_Team",
    "Sales_Team",
    "Finance_Team",
    "Executive_Access"
)

foreach ($group in $groups) {

    try {
        if (-not (Get-LocalGroup -Name $group -ErrorAction SilentlyContinue)) {

            New-LocalGroup -Name $group -Description "Enterprise RBAC Group"

            Write-Output "✔ Created group: $group"
        }
        else {
            Write-Output "ℹ Group already exists: $group"
        }
    }
    catch {
        Write-Output "❌ Failed to create group $group - $($_.Exception.Message)"
    }
}

Write-Output "`n✔ Verification:"
Get-LocalGroup | Where-Object Name -like "*Team*"