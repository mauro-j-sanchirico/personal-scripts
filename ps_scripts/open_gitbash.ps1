# =============================================================================
# open_gitbash.ps1
#
# Description:
# Convenience script to open GitBash from PowerShell.
#
# Usage:
#
# ./open_gitbash.ps1
#
# =============================================================================


$gitBashPath = "C:\Program Files\Git\bin\bash.exe"

if (Test-Path $gitBashPath) {
    Start-Process -FilePath $gitBashPath
}
else {
    Write-Host "Git Bash not found at $gitBashPath."
}