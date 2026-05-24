# DockerHermit: Containerized Hermes-Agent + Localized Ollama

[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Ollama](https://img.shields.io/badge/Ollama-black?style=for-the-badge)](https://ollama.ai/)
[![Hermes-Agent](https://img.shields.io/badge/Hermes-Agent-black?style=for-the-badge)](https://github.com/NousResearch/hermes-agent)


DockerHermit provides a fully containerized, privacy-focused environment for running the [Nous Research Hermes-Agent](https://github.com/NousResearch/hermes-agent). Powered by a local Ollama instance, this setup ensures your agentic workflows remain private while leveraging local GPU acceleration.

Version: 0.1.0

---

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [CLI Reference](#cli-reference)
- [Manual](#manual)
- [Configuration](#configuration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [License](#license)


## Features

- **Privacy First**: All LLM processing happens locally within your network.
- **GPU Accelerated**: Pre-configured support for NVIDIA Container Toolkit.
- **Easy Management**: Simplified CLI wrapper (`spawn.sh`) for stack management.
- **Persistent**: Local volume mounting for models and agent configuration.

## Architecture
- **Hermes Agent**: Running inside a dedicated container (`docker-hermit`), providing the primary interface for agentic tasks.
- **Ollama Backend**: A secondary service (`docker-llama`) that serves models via the OpenAI-compatible API.
- **Network**: Both services share a custom bridge network, allowing the agent to reach the LLM via internal DNS.

## Prerequisites

- Docker Engine and Docker Compose.
- NVIDIA Container Toolkit (if using GPU acceleration).
- Ensure the `docker-llama` service is healthy before initializing the agent.

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/dockerHermit.git
   cd dockerHermit
   ```

2. **Start the environment:**
   This will build the containers and automatically run the Hermes-Agent installation script.
   ```bash
   ./spawn.sh spawn
   ```

3. **Pull a Model:**
   ```bash
   ./spawn.sh pull qwen2.5:7b
   ```

4. **Enter the Agent CLI:**
   ```bash
   docker exec -it docker-hermit hermes
   ```

## CLI Reference (`spawn.sh`)

The `spawn.sh` script is the primary entry point for managing the stack.

| Command | Description |
| :--- | :--- |
| `./spawn.sh spawn` | Builds and starts the containers, then runs the Hermes install script. |
| `./spawn.sh spawn --no-install` | Starts the containers without triggering the installation. |
| `./spawn.sh kill` | Stops and removes all containers associated with the stack. |
| `./spawn.sh pull <model>` | Pulls a specific model into the local Ollama instance. |

## Manual 
1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/dockerHermit.git
   cd dockerHermit
   ```
2. **Build the Docker**
   ```bash
   docker compose up -d --build
   ```
3. **Install your models**
   ```bash
   docker exec -it docker-llama ollama pull qwen2.5:1.5b
   docker exec -it docker-llama ollama pull huihui_ai/qwen3.5-abliterated:0.8B
   docker exec -it docker-llama ollama pull tinyllama:1.1b
   ```
4. **Run the install**
   ```bash
   docker exec -it docker-hermit bash -c "curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash"
   ```

### Model Management
To see what models you have available:
```bash
docker exec -it docker-llama ollama list
```

## Configuration

During the installation script's TUI (Terminal User Interface), use the following settings to link the agent to your local backend:

1. **Provider**: Select `custom`.
2. **Endpoint**: Set to `http://docker-llama:11434/v1`.
3. **API Key**: Enter any string (e.g., `ollama`), or your `MCP_API_KEY` if you have configured the gateway proxy.
4. **Completion Mode**: Select option `2` (`Chat Completions`).
5. **Model**: Enter the name of the model you have pulled (e.g., `qwen2.5:7b` or `huihui_ai/qwen3.5-abliterated:9b-Claude`).

## Usage
To interact with your agent after setup:
```bash
docker exec -it docker-hermit hermes chat
```

## Troubleshooting
- **Connection Refused**: Ensure the `docker-llama` container is running and healthy. Check logs with `docker compose logs docker-llama`.
- **GPU not detected**: Refer to the detailed troubleshooting in the `dockerLLama/README.md` regarding NVIDIA drivers and the container runtime.
- **Permissions**: If you encounter volume mounting errors, ensure the `./models` directory has the correct write permissions for the container user.

## License
Distributed under the MIT License. See `LICENSE` for more information.
