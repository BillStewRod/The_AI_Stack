# Quick Reference Guide

## 🚀 Start the AI Stack

### Windows
```cmd
# Interactive launcher (recommended)
launch.bat

# Direct commands
scripts\start-amd.bat      # For AMD GPUs (7900 XTX)
scripts\start-nvidia.bat   # For NVIDIA GPUs
scripts\start-cpu.bat      # CPU-only mode
scripts\start-dev.bat      # Development mode (no auth)
```

### Linux/macOS
```bash
# Make scripts executable first
chmod +x scripts/*.sh launch.sh

# Interactive launcher
./launch.sh

# Direct commands
./scripts/start-amd.sh     # For AMD GPUs
./scripts/start-nvidia.sh  # For NVIDIA GPUs  
./scripts/start-cpu.sh     # CPU-only mode
```

## 🛑 Stop the AI Stack

```cmd
# Windows
scripts\stop.bat

# Linux/macOS
./scripts/stop.sh
```

## 🔗 Service URLs

After starting, access these services:

- **Open WebUI**: http://localhost:3000
- **ChromaDB**: http://localhost:8000  
- **n8n**: http://localhost:5678
- **Nginx Proxy Manager**: http://localhost:81
- **Ollama API**: http://localhost:11434

## 🔧 Common Commands

```bash
# Check status
docker-compose ps

# View logs
docker-compose logs -f [service_name]

# Pull updates
docker-compose pull

# Restart a service
docker-compose restart [service_name]

# Download your first model
docker exec -it ollama ollama pull llama3.1

# List available models
docker exec -it ollama ollama list
```

## ⚙️ Configuration

Edit `.env` file to customize:
- Ports
- Passwords  
- Data paths
- GPU settings

## 🩺 Troubleshooting

Run health check:
```cmd
# Windows
.\health-check.bat

# Check individual service logs
docker-compose logs [service_name]
```

## 📁 Project Structure

```
AI Stack/
├── launch.bat|sh           # Interactive launcher
├── health-check.bat        # System validation
├── .env                    # Your configuration
├── docker-compose.yml      # Base services
├── docker-compose.*.yml    # Hardware profiles
└── scripts/               # Start/stop scripts
```
