# Docker container for (local) Ollama + Local AI Tool

The main purpose is the allow "soft-isolated" use of Claude Code powered by local models (with Ollama).

1. Dockerfile for base docker image
2. Start ollama/llama server on host
3. Run `ollama launch claude` in the docker container
4. Optional: can also install and use `opencode` etc.
