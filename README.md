# Docker container for (local) Ollama + Claude Code

The main purpose is the allow "isolated" use of Claude Code powered by local models (with Ollama). Feel free to go wild, crash, and burn!

1. Build script for the base docker image
2. Install ollama models in the docker container (Requires manual setup)
3. Launch script to pass `/dev/kfd` and `/dev/dri` (amdgpu) and mount an "isolate" directory". Claude code will not be able to access other host files (except the mounted directory).
4. Run `ollama launch claude --model <local model>`
