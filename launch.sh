#!/usr/bin/env bash
# launch.sh - start Ollama + Claude dev container and attach shell

IMAGE_NAME="ollama-claude:gptoss20b"
# IMAGE_NAME="ollama-claude-base"
CONTAINER_NAME="ollama-claude"

# Check if container exists
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Container exists. Attach with 'docker start -ai <CONTAINER_NAME>'"
    # docker start -ai $CONTAINER_NAME
    exit 1
fi

if [[ -z "$1" ]]; then
    echo "Missing directory to launch in"
    exit 1
fi

# Run new container
docker run -it \
    --name $CONTAINER_NAME \
    --device=/dev/kfd \
    --device=/dev/dri \
    -v "$1":/workspace \
    $IMAGE_NAME \
    bash -c "OLLAMA_FLASH_ATTENTION=1 OLLAMA_CONTEXT_LENGTH=32768 OLLAMA_NO_CLOUD=1 ollama serve > /dev/null 2>&1 & exec bash"
