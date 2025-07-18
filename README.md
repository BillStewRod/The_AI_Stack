# AI Services Stack

This repository contains a stack of different AI services that can be deployed together.

Here’s the plan:

*   **Base docker-compose.yml**: This file will contain all the services that are common to every setup, like Open WebUI, Nginx Proxy Manager, n8n, and ChromaDB.
*   **Profile-Specific Files**: We will create separate docker-compose.override.yml files for each hardware target. For example:
- docker-compose.nvidia.yml: Configures Ollama to use an NVIDIA GPU.
- docker-compose.amd.yml: Configures Ollama to use an AMD GPU (like your 7900 XTX).
- docker-compose.cpu.yml: Configures Ollama to run on the CPU only.
*   **Environment Variables (.env)**: We'll use an .env file to manage settings like data paths, which can differ between operating systems.
*   **Helper Scripts**: To make it easy to start the correct configuration, we can create simple scripts (e.g., start-nvidia.bat, start-amd.sh) that automatically select the right files.

## Services

Here is a list of the services included in this stack:

*   **Ollama**: A service for running large language models locally.
*   **Open WebUI**: A user-friendly web interface for interacting with LLMs, similar to ChatGPT.
*   **ChromaDB**: An open-source vector database for Retrieval-Augmented Generation (RAG).
*   **Watchtower**: A service that automatically updates running Docker containers to the latest version.
*   **n8n**: A workflow automation tool that can be used to connect different services and APIs.
*   **Nginx Proxy Manager**: A reverse proxy for managing SSL certificates and routing traffic to different services.
*   **MCP Server (Placeholder)**: A template for building a service that implements the Model-Context-Protocol.

## Getting Started

### Prerequisites

- Docker and Docker Compose installed
- For GPU support:
  - **NVIDIA**: NVIDIA Docker runtime and drivers
  - **AMD**: ROCm drivers and Docker support
- At least 8GB RAM (16GB+ recommended for larger models)
- 20GB+ free disk space

### Quick Start

1. **Clone this repository**
   ```bash
   git clone <repository-url>
   cd AIStackNew
   ```

2. **Set up environment**
   ```bash
   # Copy environment template
   cp .env.example .env
   
   # Edit .env with your preferred settings
   # nano .env  # Linux/macOS
   # notepad .env  # Windows
   ```

3. **Choose your hardware profile and start the stack**

   **For Windows:**
   ```cmd
   # AMD GPU (Windows optimized)
   scripts\start-amd.bat
   
   # AMD GPU (Linux - ROCm) - Only if running Linux containers
   scripts\start-amd-linux.bat
   
   # NVIDIA GPU
   scripts\start-nvidia.bat
   
   # CPU Only
   scripts\start-cpu.bat
   ```

   **For Linux/macOS:**
   ```bash
   # Make scripts executable
   chmod +x scripts/*.sh
   
   # AMD GPU (Linux - ROCm)
   ./scripts/start-amd.sh
   
   # NVIDIA GPU
   ./scripts/start-nvidia.sh
   
   # CPU Only
   ./scripts/start-cpu.sh
   ```

4. **Access the services**
   - **Open WebUI**: http://localhost:3000 (ChatGPT-like interface)
   - **ChromaDB**: http://localhost:8000 (Vector database API)
   - **n8n**: http://localhost:5678 (Workflow automation)
   - **Nginx Proxy Manager**: http://localhost:81 (Reverse proxy management)
   - **Ollama API**: http://localhost:11434 (LLM API endpoint)

### Configuration

#### Environment Variables

Key settings in `.env`:

- `GPU_TYPE`: Set to `amd`, `nvidia`, or `cpu`
- `WEBUI_SECRET_KEY`: Secret key for Open WebUI (generate a strong random string)
- `N8N_BASIC_AUTH_PASSWORD`: Password for n8n access
- Port configurations for all services
- Data paths for persistent storage

#### Hardware-Specific Notes

**AMD GPU (Windows)**:
- Uses `ollama/ollama:latest` with CPU optimizations
- Resource limits to prevent system overload
- Optimized for Windows Docker Desktop

**AMD GPU (Linux - ROCm)**:
- Uses `ollama/ollama:rocm` image
- Full ROCm GPU acceleration
- Requires ROCm drivers and `/dev/kfd`, `/dev/dri` access

**NVIDIA GPU**:
- Uses `ollama/ollama:latest` with NVIDIA runtime
- Requires NVIDIA Container Toolkit
- GPU memory will be automatically detected

**CPU Only**:
- Resource limits applied to prevent system overload
- Slower inference but works on any system

### Managing the Stack

**Stop the stack:**
```bash
# Windows
scripts\stop.bat

# Linux/macOS
./scripts/stop.sh
```

**View logs:**
```bash
docker-compose logs -f [service_name]
```

**Update containers:**
Watchtower automatically updates containers daily, or manually:
```bash
docker-compose pull
docker-compose up -d
```

### Initial Setup Tasks

1. **Ollama Models**: Pull your first model
   ```bash
   docker exec -it ollama ollama pull llama2
   ```

2. **n8n**: Access http://localhost:5678 with credentials from `.env`

3. **Nginx Proxy Manager**: 
   - Access http://localhost:81
   - Default: admin@example.com / changeme
   - Change default credentials immediately

### Troubleshooting

**AMD GPU issues:**
- Ensure ROCm drivers are installed
- Check `/dev/kfd` and `/dev/dri` permissions
- Verify GPU is detected: `rocm-smi`

**NVIDIA GPU issues:**
- Install NVIDIA Container Toolkit
- Verify: `docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`

**General issues:**
- Check Docker daemon is running
- Verify port availability
- Check logs: `docker-compose logs`

## Project Structure

```
├── README.md                     # This file
├── .env.example                  # Environment template
├── .gitignore                    # Git ignore rules
├── docker-compose.yml            # Base services
├── docker-compose.nvidia.yml     # NVIDIA GPU profile
├── docker-compose.amd.yml        # Legacy AMD profile
├── docker-compose.amd-windows.yml # AMD GPU (Windows)
├── docker-compose.amd-linux.yml  # AMD GPU (Linux ROCm)
├── docker-compose.cpu.yml        # CPU-only profile
├── docker-compose.mcp.yml        # MCP server (placeholder)
├── scripts/                      # Deployment scripts
│   ├── start-nvidia.bat|sh      # NVIDIA startup
│   ├── start-amd.bat|sh         # AMD startup (Windows/Linux)
│   ├── start-amd-linux.bat      # AMD Linux from Windows
│   ├── start-cpu.bat|sh         # CPU startup
│   └── stop.bat|sh              # Stop all services
├── config/                       # Service configurations
└── data/                         # Persistent data (auto-created)
```

## Contributing

We welcome contributions! Please:

1. Fork the repository
2. Create a feature branch
3. Test your changes with different hardware profiles
4. Submit a pull request with clear description

### Areas for Contribution

- Additional GPU support (Intel Arc, Apple Silicon)
- More AI services integration
- Monitoring and logging improvements
- Security enhancements
- Documentation improvements

## License

[Add your preferred license here]

## Support

- Create an issue for bug reports
- Discussions for questions and ideas
- Wiki for advanced configurations
