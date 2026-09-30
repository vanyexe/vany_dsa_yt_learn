# ==========================================
# Vany DSA - Automatic GitHub Push
# ==========================================

# Find repository root
$RepoPath = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

Set-Location $RepoPath

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "        VANY DSA - GITHUB PUSH" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check Git repository
if (-not (Test-Path ".git")) {
    Write-Host "ERROR: This folder is not a Git repository." -ForegroundColor Red
    exit 1
}

# Check for changes
$status = git status --porcelain

if (-not $status) {
    Write-Host "No changes to push." -ForegroundColor Yellow
    Write-Host ""
    exit 0
}

# Show changes
Write-Host "Changes detected:" -ForegroundColor Green
git status --short

Write-Host ""

# Add everything
git add .

# Get current date
$date = Get-Date -Format "yyyy-MM-dd"

# Get changed files
$files = git diff --cached --name-only

# Create commit message
if ($files) {

    $firstFile = $files | Select-Object -First 1

    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($firstFile)

    if ($fileName) {
        $commitMessage = "DSA: $fileName - $date"
    }
    else {
        $commitMessage = "DSA practice - $date"
    }

}
else {

    $commitMessage = "DSA practice - $date"

}

Write-Host "Commit message:" -ForegroundColor Cyan
Write-Host $commitMessage
Write-Host ""

# Commit
git commit -m "$commitMessage"

if ($LASTEXITCODE -ne 0) {
    Write-Host "Commit failed." -ForegroundColor Red
    exit 1
}

# Push
Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Cyan

git push

if ($LASTEXITCODE -ne 0) {

    Write-Host ""
    Write-Host "Push failed." -ForegroundColor Red

    exit 1
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "       SUCCESSFULLY PUSHED TO GITHUB" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""