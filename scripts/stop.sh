#!/bin/bash

echo "Stopping AI Stack..."

# Stop all possible combinations
docker-compose -f docker-compose.yml -f docker-compose.nvidia.yml down 2>/dev/null
docker-compose -f docker-compose.yml -f docker-compose.amd.yml down 2>/dev/null
docker-compose -f docker-compose.yml -f docker-compose.amd-windows.yml down 2>/dev/null
docker-compose -f docker-compose.yml -f docker-compose.amd-linux.yml down 2>/dev/null
docker-compose -f docker-compose.yml -f docker-compose.cpu.yml down 2>/dev/null

echo "AI Stack stopped."
