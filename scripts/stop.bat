@echo off
echo Stopping AI Stack...

REM Stop all possible combinations
docker-compose -f docker-compose.yml -f docker-compose.nvidia.yml down 2>nul
docker-compose -f docker-compose.yml -f docker-compose.amd.yml down 2>nul
docker-compose -f docker-compose.yml -f docker-compose.amd-windows.yml down 2>nul
docker-compose -f docker-compose.yml -f docker-compose.amd-linux.yml down 2>nul
docker-compose -f docker-compose.yml -f docker-compose.cpu.yml down 2>nul

echo AI Stack stopped.
pause
