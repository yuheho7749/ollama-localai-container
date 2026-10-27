#!/usr/bin/env bash set -e

IMAGE_NAME="ollama-claude:latest"
CONTAINER_NAME="ollama-claude"

# Check if container exists
if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    if [ "$(docker inspect -f '{{ .State.Running }}' "$CONTAINER_NAME")" = "true" ]; then
        echo "Reusing running container"
        docker exec -it "$CONTAINER_NAME" bash
    else
        echo "Start and reusing stopped container"
        docker start "$CONTAINER_NAME" >/dev/null
        docker exec -it "$CONTAINER_NAME" bash
    fi
else
    if [[ -z "$1" ]]; then
        echo "Missing directory to launch in"
        exit 1
    fi

    echo "Starting new container"

    # Run new container
    docker run -it \
        --name "$CONTAINER_NAME" \
        --add-host=host.docker.internal:host-gateway \
        -v "$1":/workspace \
        "$IMAGE_NAME" \
        bash
fi
