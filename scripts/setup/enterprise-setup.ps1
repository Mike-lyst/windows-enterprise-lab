
$base = "C:\Dev\windows-enterprise-lab\EnterpriseData"

Write-Output " Setting up enterprise environment..."


# Ensure base folder exists
New-Item -Path $base -ItemType Directory -Force | Out-Null

$folders = @(
    "IT",
    "Engineering",
    "Quality Control",
    "Sales",
    "Finance"
)

foreach ($folder in $folders) {
    New-Item -Path "$base\$folder" -ItemType Directory -Force | Out-Null
    Write-Output "Created: $base\$folder"
}

Write-Output "✅ Enterprise folders created successfully"
