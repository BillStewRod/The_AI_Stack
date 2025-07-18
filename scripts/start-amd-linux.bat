@echo off
echo Starting AI Stack with AMD GPU support (Linux - ROCm)...
echo.
echo WARNING: This configuration requires Linux with ROCm drivers!
echo If you're on Windows, use option 1 instead.
echo.
pause

REM Check if .env file exists
if not exist ".env" (
    echo .env file not found. Creating from template...
    copy ".env.example" ".env"
    echo Please edit .env file with your settings and run this script again.
    pause
    exit /b 1
)

REM Start the stack
docker-compose -f docker-compose.yml -f docker-compose.amd-linux.yml up -d

echo.
echo AI Stack is starting up...
echo.
echo Services will be available at:
echo - Open WebUI: http://localhost:3000
echo - ChromaDB: http://localhost:8000
echo - n8n: http://localhost:5678
echo - Nginx Proxy Manager: http://localhost:81
echo - Ollama API: http://localhost:11434
echo.
echo To stop the stack, run: docker-compose -f docker-compose.yml -f docker-compose.amd-linux.yml down
echo.
pause
