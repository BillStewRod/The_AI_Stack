#!/bin/bash

echo "Starting AI Stack with NVIDIA GPU support..."

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo ".env file not found. Creating from template..."
    cp ".env.example" ".env"
    echo "Please edit .env file with your settings and run this script again."
    exit 1
fi

# Start the stack
docker-compose -f docker-compose.yml -f docker-compose.nvidia.yml up -d

echo ""
echo "AI Stack is starting up..."
echo ""
echo "Services will be available at:"
echo "- Open WebUI: http://localhost:3000"
echo "- ChromaDB: http://localhost:8000"
echo "- n8n: http://localhost:5678"
echo "- Nginx Proxy Manager: http://localhost:81"
echo "- Ollama API: http://localhost:11434"
echo ""
echo "To stop the stack, run: docker-compose -f docker-compose.yml -f docker-compose.nvidia.yml down"
echo ""
