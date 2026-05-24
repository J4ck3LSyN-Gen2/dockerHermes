#!/usr/bin/env bash

case "$1" in
    spawn)
        docker compose up -d --build
        if [[ "$2" != "--no-install" ]]; then
            docker exec -it docker-hermit bash -c "curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash"
        fi
        ;;
    kill)
        docker compose down
        ;;
    pull)
        if [ -z "$2" ]; then
            echo "Usage: $0 pull <model>"
            exit 1
        fi
        docker exec -it docker-llama ollama pull "$2"
        ;;
    *)
        echo "Usage: $0 {spawn [--no-install]|kill|pull <model>}"
        exit 1
        ;;
esac
