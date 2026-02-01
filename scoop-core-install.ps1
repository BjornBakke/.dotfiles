# =============================================================================
# SCOOP CORE - Installerer Scoop, git og buckets
# =============================================================================

Write-Host "🚀 Installerer Scoop core" -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Green

# 1. Sett installasjonsmappe som miljøvariabel
$env:SCOOP = "D:\programmer\scoop"
[Environment]::SetEnvironmentVariable("SCOOP", $env:SCOOP, "User")
Write-Host "📁 Scoop installeres til: $env:SCOOP" -ForegroundColor Cyan

if (-not (Test-Path $env:SCOOP)) {
    New-Item -ItemType Directory -Path $env:SCOOP -Force | Out-Null
}

# 2. Execution Policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# 3. Installer Scoop
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Installerer Scoop..." -ForegroundColor Yellow
    iwr -useb https://get.scoop.sh | iex
    $env:PATH = "$env:SCOOP\shims;$env:PATH"
    Write-Host "✅ Scoop installert!" -ForegroundColor Green
}
else {
    Write-Host "✔ Scoop allerede installert." -ForegroundColor Cyan
}

# 4. Installer 7zip og git
Write-Host "⬇ Installerer 7zip og git..." -ForegroundColor Yellow
scoop install 7zip
scoop install git

# 5. Legg til buckets
Write-Host "📚 Legger til buckets..." -ForegroundColor Yellow
scoop bucket add extras
scoop bucket add versions
scoop bucket add java

Write-Host "✅ Core ferdig! Kjør 2-install-apps.ps1 for programmer." -ForegroundColor Green