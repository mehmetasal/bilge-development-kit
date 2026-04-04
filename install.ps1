# BDK Install Script (PowerShell)
# Usage: .\bilge-development-kit\install.ps1 [target-dir]

param(
    [string]$Target = "."
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Target = Resolve-Path $Target -ErrorAction SilentlyContinue

if (-not $Target) {
    Write-Host "Error: Target directory does not exist." -ForegroundColor Red
    exit 1
}

$Target = $Target.Path

if ($ScriptDir -eq $Target) {
    Write-Host "Error: Target cannot be the BDK repo itself." -ForegroundColor Red
    exit 1
}

# Check if .agent/ already exists
if (Test-Path "$Target\.agent") {
    Write-Host "Warning: $Target\.agent already exists." -ForegroundColor Yellow
    $confirm = Read-Host "Overwrite? (y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Aborted."
        exit 0
    }
    Remove-Item -Recurse -Force "$Target\.agent"
}

# Check if .claude/ already exists
if (Test-Path "$Target\.claude") {
    Write-Host "Warning: $Target\.claude already exists." -ForegroundColor Yellow
    $confirm = Read-Host "Overwrite? (y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Skipping .claude/ (keeping existing)" -ForegroundColor Yellow
    } else {
        Remove-Item -Recurse -Force "$Target\.claude"
        Copy-Item -Recurse "$ScriptDir\.claude" "$Target\.claude"
        Write-Host "  [+] .claude/ copied to project root" -ForegroundColor Green
    }
} else {
    Copy-Item -Recurse "$ScriptDir\.claude" "$Target\.claude"
    Write-Host "  [+] .claude/ copied to project root" -ForegroundColor Green
}

Write-Host "Installing BDK to: $Target" -ForegroundColor Cyan
Write-Host ""

# Copy .agent/ (main toolkit)
Copy-Item -Recurse "$ScriptDir" "$Target\.agent"
Write-Host "  [+] .agent/ copied" -ForegroundColor Green

# Remove nested .git if exists
if (Test-Path "$Target\.agent\.git") {
    Remove-Item -Recurse -Force "$Target\.agent\.git"
}

# Remove install scripts from .agent/ (not needed inside project)
Remove-Item -Force "$Target\.agent\install.sh" -ErrorAction SilentlyContinue
Remove-Item -Force "$Target\.agent\install.ps1" -ErrorAction SilentlyContinue
Write-Host "  [+] cleaned up" -ForegroundColor Green

Write-Host ""
Write-Host "BDK installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. cd $Target"
Write-Host "  2. Run /onboard to initialize project context"
Write-Host ""
