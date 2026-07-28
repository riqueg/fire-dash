# =============================================================
# setup.ps1 — Configuracao inicial (rode UMA VEZ so)
# =============================================================
# Como usar:
#   1. Abra o PowerShell nesta pasta
#   2. Execute: .\setup.ps1 -GitHubUser SEU_USUARIO -RepoName firedoor
# =============================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubUser,

    [Parameter(Mandatory=$true)]
    [string]$RepoName = "firedoor"
)

$ErrorActionPreference = "Stop"
$deployDir = $PSScriptRoot

Write-Host ""
Write-Host "=== Firedoor Deploy — Setup inicial ===" -ForegroundColor Cyan
Write-Host ""

# Verifica se git esta instalado
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "ERRO: Git nao encontrado." -ForegroundColor Red
    Write-Host "Instale em: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

Set-Location $deployDir

# Inicializa o repositorio git
if (-not (Test-Path ".git")) {
    git init -b main
    Write-Host "Repositorio git inicializado." -ForegroundColor Green
} else {
    Write-Host "Repositorio git ja existe." -ForegroundColor Yellow
}

# Configura o remote
$remoteUrl = "https://github.com/$GitHubUser/$RepoName.git"
$existingRemote = git remote 2>$null

if ($existingRemote -contains "origin") {
    git remote set-url origin $remoteUrl
    Write-Host "Remote 'origin' atualizado para: $remoteUrl" -ForegroundColor Green
} else {
    git remote add origin $remoteUrl
    Write-Host "Remote 'origin' adicionado: $remoteUrl" -ForegroundColor Green
}

# Primeiro commit e push
git add index.html .gitignore deploy.ps1 setup.ps1
git commit -m "deploy inicial — firedoor dashboard"
git push -u origin main

Write-Host ""
Write-Host "=== Pronto! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Cyan
Write-Host "  1. Acesse github.com/$GitHubUser/$RepoName"
Write-Host "  2. Va em Settings > Pages"
Write-Host "  3. Em 'Source', selecione: Branch: main | Folder: / (root)"
Write-Host "  4. Clique Save"
Write-Host "  5. Aguarde ~1 minuto"
Write-Host "  6. URL do dashboard: https://$GitHubUser.github.io/$RepoName/"
Write-Host ""
