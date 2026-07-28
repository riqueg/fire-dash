# =============================================================
# deploy.ps1 — Publica a versao mais recente do dashboard
# =============================================================
# Rode este script sempre que o dashboard for atualizado.
# Pode ser chamado manualmente ou pelo Cowork automaticamente.
# =============================================================

$ErrorActionPreference = "Stop"
$deployDir  = $PSScriptRoot
$sourceFile = Join-Path $PSScriptRoot "..\firedoor_dashboard_v2 (1).html"
$destFile   = Join-Path $deployDir "index.html"

Write-Host ""
Write-Host "=== Firedoor Deploy ===" -ForegroundColor Cyan

# Verifica se o arquivo fonte existe
if (-not (Test-Path $sourceFile)) {
    Write-Host "ERRO: Arquivo fonte nao encontrado: $sourceFile" -ForegroundColor Red
    exit 1
}

# Copia o dashboard atualizado
Copy-Item $sourceFile $destFile -Force
$size = [math]::Round((Get-Item $destFile).Length / 1KB)
Write-Host "Dashboard copiado ($size KB)" -ForegroundColor Green

# Commit e push
Set-Location $deployDir

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git add index.html
$status = git status --porcelain

if ($status) {
    git commit -m "dados atualizados em $timestamp"
    git push
    Write-Host "Publicado com sucesso!" -ForegroundColor Green
    Write-Host "O dashboard online atualiza em ~30 segundos." -ForegroundColor Cyan
} else {
    Write-Host "Nenhuma alteracao detectada. Nada para publicar." -ForegroundColor Yellow
}

Write-Host ""
