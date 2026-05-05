Write-Output "🔐 Creating REAL Windows local users..."

for ($i = 1; $i -le 20; $i++) {

    $username = "user$i"

    try {
        if (-not (Get-LocalUser -Name $username -ErrorAction SilentlyContinue)) {

            $password = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force

            New-LocalUser `
                -Name $username `
                -Password $password `
                -AccountNeverExpires `
                -PasswordNeverExpires `
                -Description "Enterprise Lab User"

            Write-Output "✔ Created $username"
        }
        else {
            Write-Output "ℹ $username already exists"
        }
    }
    catch {
        Write-Output "❌ Failed to create $username - $($_.Exception.Message)"
    }
}

Write-Output "`n✔ Verification:"
Get-LocalUser | Where-Object Name -like "user*"