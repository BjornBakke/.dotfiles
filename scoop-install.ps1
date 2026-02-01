# =============================================================================
# SCOOP MINIMAL INSTALLASJONSSKRIPT
# Installerer Scoop + utvalgte verktøy (uten administratorrettigheter)
# =============================================================================

Write-Host "🚀 Starter installasjon av Scoop og valgte programmer" -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Green

# 0. Velg installasjonsmappe
Write-Host "📁 Velg hvor Scoop skal installeres:" -ForegroundColor Yellow
Write-Host "  1) Standard (C:\Users\<Bruker>\scoop)"
Write-Host "  2) Foreslått mappe: D:\Applications\scoop"
Write-Host "  3) Skriv inn en helt valgfri mappe"
$choice = Read-Host "Skriv 1, 2 eller 3"

switch ($choice) {
    "1" {
        $scoopDir = $null
        Write-Host "➡ Standard installasjonsmappe valgt." -ForegroundColor Cyan
    }
    "2" {
        $scoopDir = "D:\Applications\Scoop"
        Write-Host "➡ Bruker egendefinert mappe: $scoopDir" -ForegroundColor Cyan
    }
    "3" {
        $custom = Read-Host "Skriv inn ønsket mappe (f.eks. D:\ScoopApps)"
        if ([string]::IsNullOrWhiteSpace($custom)) {
            Write-Host "⚠ Ingen mappe oppgitt. Standard mappe brukes." -ForegroundColor Red
            $scoopDir = $null
        }
        else {
            $scoopDir = $custom
            Write-Host "➡ Valgt mappe: $scoopDir" -ForegroundColor Cyan
        }
    }
    default {
        Write-Host "⚠ Ugyldig valg. Standard mappe brukes." -ForegroundColor Red
        $scoopDir = $null
    }
}

# Opprett mappe hvis nødvendig
if ($scoopDir) {
    if (-not (Test-Path $scoopDir)) {
        Write-Host "📂 Mappen finnes ikke. Oppretter: $scoopDir" -ForegroundColor Yellow
        New-Item -ItemType Directory -Path $scoopDir -Force | Out-Null
    }
    else {
        Write-Host "📂 Mappen finnes allerede: $scoopDir" -ForegroundColor Green
    }
}

# 1. Konfigurer PowerShell Execution Policy
Write-Host "📋 Konfigurerer PowerShell-sikkerhet..." -ForegroundColor Yellow
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# 2. Installer Scoop (hvis ikke allerede installert)
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Installerer Scoop..." -ForegroundColor Yellow

    if ($scoopDir) {
        Invoke-RestMethod -Uri https://get.scoop.sh -ScoopDir $scoopDir | Invoke-Expression
    }
    else {
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    }

    Write-Host "✅ Scoop ble installert!" -ForegroundColor Green
}
else {
    Write-Host "✔ Scoop er allerede installert. Hopper over installasjon." -ForegroundColor Cyan
}

# 3. Legg til nødvendige buckets
Write-Host "📚 Legger til Scoop-buckets..." -ForegroundColor Yellow
scoop bucket add extras
scoop bucket add versions
scoop bucket add java

# 4. Installer valgte programmer
Write-Host "🛠️ Installerer programmer..." -ForegroundColor Yellow

$apps = @(
    "7zip","cacert","dotnet-sdk","fiddler","fzf","git","maven","microsoft-jdk",
    "neofetch","nodejs","oh-my-posh","pycharm-latest","revouninstaller",
    "rider","uv","vscode","wget","winscp","postgresql","wireshark"
)

foreach ($app in $apps) {
    if (-not (scoop list | Select-String -Quiet $app)) {
        Write-Host "⬇ Installerer $app..." -ForegroundColor White
        scoop install $app
    }
    else {
        Write-Host "✔ $app er allerede installert." -ForegroundColor Green
    }
}

# 5. Sluttkonfigurasjon
Write-Host "🔧 Utfører sluttkonfigurasjon..." -ForegroundColor Yellow

Write-Host "  → Oppdaterer alle pakker..." -ForegroundColor White
scoop update *

Write-Host "  → Rydder opp gamle versjoner..." -ForegroundColor White
scoop cleanup *

# Vis installert status
Write-Host "📊 Installerte programmer:" -ForegroundColor Green
scoop list

Write-Host "🎉 Installasjonen er fullført!" -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Green