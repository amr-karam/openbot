# OpenBot launcher — Windows Defender CFA-safe.
# Starts uvicorn with all writable state redirected to C:\openbot-data.
# Run: powershell -ExecutionPolicy Bypass -File start-openbot.ps1

$ErrorActionPreference = "Stop"

$backendDir = "C:\Users\amrmo\openbot\backend"
$python = Join-Path $backendDir ".venv\Scripts\python.exe"

# Redirect all writable OpenBot state outside the CFA-guarded user profile.
$env:OPENBOT_ROOT_DIRECTORY = "C:\openbot-data"
$env:DATABASE_URL = "sqlite+aiosqlite:///C:\openbot-data\.openbot\openbot.db"
$env:WORKSPACE_ROOT = "C:\openbot-data\workspace"
$env:SECRET_KEY_FILE = "C:\openbot-data\.openbot\secret.key"
$env:LOG_FILE = "nul"
$env:LANGSMITH_TRACING = "false"

# Ensure directories exist.
New-Item -ItemType Directory -Path "C:\openbot-data\.openbot" -Force | Out-Null
New-Item -ItemType Directory -Path "C:\openbot-data\workspace" -Force | Out-Null

Set-Location $backendDir
Write-Host "OpenBot backend dir: $backendDir" -ForegroundColor Cyan
Write-Host "State root: C:\openbot-data (CFA-safe)" -ForegroundColor Cyan
Write-Host "Starting uvicorn on http://localhost:8000 ..." -ForegroundColor Cyan
& $python -m uvicorn openbot.main:app --reload --port 8000
