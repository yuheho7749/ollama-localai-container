FROM ubuntu:24.04

# base packages
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    git \
    python3 \
    python3-pip \
    sudo \
    zstd \
    pciutils \
    vim \
    tmux

# create user and make sure have sudo
RUN id -u ubuntu &>/dev/null || useradd -m -s /bin/bash ubuntu
RUN usermod -aG sudo ubuntu
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu
WORKDIR /workspace

# ollama
RUN curl -fsSL https://ollama.com/install.sh | sh
ENV OLLAMA_HOST=http://host.docker.internal:11434

# claude code
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="/home/ubuntu/.local/bin:${PATH}"
ENV ANTHROPIC_BASE_URL=http://host.docker.internal:11434
ENV ANTHROPIC_AUTH_TOKEN=ollama

# opencode
RUN curl -fsSL https://opencode.ai/v2/install | bash
