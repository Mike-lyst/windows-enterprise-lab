Write-Host "🚀 Starting Enterprise Lab..." -ForegroundColor Cyan
Write-Host "-------------------------------------"

$simPath = $PSScriptRoot

# -------------------------------
# Load Modules Safely
# -------------------------------
Write-Host "🔐 Loading RBAC..." -ForegroundColor Yellow

. (Join-Path $simPath "rbac-setup.ps1")
. (Join-Path $simPath "rbac-engine.ps1")

Write-Host "✅ RBAC modules loaded"
Write-Host ""
Write-Host "🧪 Running Access Tests..."
Write-Host "-------------------------------------"

# -------------------------------
# Test Cases
# -------------------------------
Test-Access "user1" "IT"
Test-Access "user5" "Engineering"
Test-Access "user13" "Engineering"
Test-Access "user17" "Finance"
Test-Access "user20" "Finance"

Write-Host "-------------------------------------"
Write-Host "✅ Lab complete"