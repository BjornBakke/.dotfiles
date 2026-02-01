# =============================================================================
# SCOOP APPS - Installerer programmer
# =============================================================================

Write-Host "🛠️ Installerer programmer via Scoop" -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Green

$apps = @(
    "oh-my-posh",
    "maven",
    "nodejs",
    "microsoft-jdk",
    "cacert",
    "dotnet-sdk",
    "fzf",
    "vscode"
    "pycharm-latest",
    "rider",
    "uv",
)

foreach ($app in $apps) {
    Write-Host "⬇ Installerer $app..." -ForegroundColor White
    scoop install $app
}

Write-Host "🔧 Oppdaterer og rydder opp..." -ForegroundColor Yellow
scoop update *
scoop cleanup *

Write-Host "📊 Installerte programmer:" -ForegroundColor Green
scoop list

Write-Host "🎉 Ferdig!" -ForegroundColor Green
