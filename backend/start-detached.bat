@echo off
setlocal
set OPENBOT_ROOT_DIRECTORY=C:\openbot-data
set DATABASE_URL=sqlite+aiosqlite:///C:/openbot-data/.openbot/openbot.db
set WORKSPACE_ROOT=C:/openbot-data/workspace
set SECRET_KEY_FILE=C:/openbot-data/.openbot/secret.key
set LOG_FILE=nul
set LANGSMITH_TRACING=false
cd /d "C:\Users\amrmo\openbot\backend"
start "" /b .\.venv\Scripts\python.exe -m uvicorn openbot.main:app --reload --host 0.0.0.0 --port 8000
echo OpenBot started detached on 0.0.0.0:8000 (Tailscale: 100.79.173.15:8000)
