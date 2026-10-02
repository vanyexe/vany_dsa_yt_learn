Set-Location "${PSScriptRoot}\.."

Write-Host ""
Write-Host "===================================="
Write-Host "       VANY DSA - GITHUB PUSH"
Write-Host "===================================="
Write-Host ""

git add .

$changes = git status --porcelain

if (-not $changes) {
    Write-Host "No new changes to commit."
    git push origin main
    exit
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

git commit -m "Update DSA - $timestamp"

git push origin main

Write-Host ""
Write-Host "===================================="
Write-Host "        GITHUB PUSH COMPLETED"
Write-Host "===================================="