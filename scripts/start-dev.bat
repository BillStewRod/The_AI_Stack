@echo off
echo Starting AI Stack in DEVELOPMENT mode with AMD GPU support...
echo WARNING: Authentication is disabled for development!

REM Check if .env file exists
if not exist ".env" (
    echo .env file not found. Creating from template...
    copy ".env.example" ".env"
    echo Please edit .env file with your settings and run this script again.
    pause
    exit /b 1
)

REM Start the stack with development overrides
docker-compose -f docker-compose.yml -f docker-compose.amd-windows.yml -f docker-compose.dev.yml up -d

echo.
echo AI Stack (DEV MODE) is starting up...
echo.
echo Services will be available at:
echo - Open WebUI: http://localhost:3000 (NO AUTH)
echo - ChromaDB: http://localhost:8000
echo - n8n: http://localhost:5678 (NO AUTH)
echo - Nginx Proxy Manager: http://localhost:81
echo - Ollama API: http://localhost:11434
echo - Portainer: http://localhost:9000
echo.
echo To stop the stack, run: scripts\stop.bat
echo.
pause
