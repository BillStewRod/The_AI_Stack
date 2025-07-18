@echo off
echo ===================================
echo    AI Stack Health Check
echo ===================================
echo.

echo Checking Docker...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker not found! Please install Docker Desktop.
    goto end
) else (
    echo ✅ Docker is installed
)

echo Checking Docker service...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running! Please start Docker Desktop.
    goto end
) else (
    echo ✅ Docker is running
)

echo Checking Docker Compose...
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker Compose not found!
    goto end
) else (
    echo ✅ Docker Compose is available
)

echo.
echo Checking configuration files...
if exist ".env" (
    echo ✅ .env file exists
) else (
    echo ⚠️  .env file missing - will be created on first run
)

if exist "docker-compose.yml" (
    echo ✅ Base configuration found
) else (
    echo ❌ docker-compose.yml missing!
    goto end
)

echo.
echo Testing AMD GPU configuration...
docker-compose -f docker-compose.yml -f docker-compose.amd.yml config --quiet >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ AMD configuration has errors
) else (
    echo ✅ AMD GPU configuration is valid
)

echo Testing NVIDIA GPU configuration...
docker-compose -f docker-compose.yml -f docker-compose.nvidia.yml config --quiet >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ NVIDIA configuration has errors
) else (
    echo ✅ NVIDIA GPU configuration is valid
)

echo Testing CPU configuration...
docker-compose -f docker-compose.yml -f docker-compose.cpu.yml config --quiet >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ CPU configuration has errors
) else (
    echo ✅ CPU configuration is valid
)

echo.
echo ===================================
echo All checks completed!
echo ===================================

:end
echo.
pause
