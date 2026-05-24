# DockerLLama

![Python 3.12](https://img.shields.io/badge/python-3.12-green)
![Ollama Supported](https://img.shields.io/badge/Ollama%20Supported-blue)
![MCP](https://img.shields.io/badge/Network%20Traffic%20Obfuscation-green)
![Version 0.0.3](https://img.shields.io/badge/Version%200.0.3-yellow)

---

Author: J4ck3LSyN  
Version: 0.0.5(hermes-agent variant)

---

Hardened local Ollama deployment with a separate MCP gateway service.

- `ollama-node` runs the Ollama model runtime on an internal network.
- Model weights persist on the host under `./models`; Ollama runtime state is kept in a Docker volume.

## Architecture

- **Ollama service**: `ollama-node` (`ollama/ollama:latest`)
- **Network isolation**:
  - `backendIsolated` (internal-only)
  - `frontendAccess` (for local client access)

## Prerequisites

- Linux host
- Docker Engine + `docker-compose` (legacy CLI is fine)

**NOTE:** You will possibly need to create a `models` directory to allow for the ollama models.

## Information

This is a modified version of https://github.com/J4ck3LSyN-Gen2/dockerLlama.
