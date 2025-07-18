@echo off
title AI Stack Launcher

:menu
cls
echo ===================================
echo        AI Stack Launcher
echo ===================================
echo.
echo Select your hardware configuration:
echo.
echo 1. AMD GPU (Windows) - Optimized for Windows AMD GPUs
echo 2. AMD GPU (Linux) - ROCm for Linux AMD GPUs
echo 3. NVIDIA GPU - For NVIDIA GeForce/Tesla cards
echo 4. CPU Only - No GPU acceleration
echo 5. Development Mode - AMD + Dev tools (No Auth)
echo 6. Stop AI Stack
echo 7. Exit
echo.
set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" goto amd-windows
if "%choice%"=="2" goto amd-linux
if "%choice%"=="3" goto nvidia
if "%choice%"=="4" goto cpu
if "%choice%"=="5" goto dev
if "%choice%"=="6" goto stop
if "%choice%"=="7" goto exit
goto menu

:amd-windows
echo Starting with AMD GPU support (Windows)...
call scripts\start-amd.bat
goto menu

:amd-linux
echo Starting with AMD GPU support (Linux - ROCm)...
echo NOTE: This requires Linux with ROCm drivers installed
docker-compose -f docker-compose.yml -f docker-compose.amd-linux.yml up -d
echo.
echo Services will be available at:
echo - Open WebUI: http://localhost:3000
echo - ChromaDB: http://localhost:8000
echo - n8n: http://localhost:5678
echo - Nginx Proxy Manager: http://localhost:81
echo - Ollama API: http://localhost:11434
echo.
pause
goto menu

:nvidia
echo Starting with NVIDIA GPU support...
call scripts\start-nvidia.bat
goto menu

:cpu
echo Starting with CPU-only support...
call scripts\start-cpu.bat
goto menu

:dev
echo Starting in development mode...
call scripts\start-dev.bat
goto menu

:stop
echo Stopping AI Stack...
call scripts\stop.bat
goto menu

:exit
echo Goodbye!
exit
