FROM python:3.11-slim-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    nodejs \
    npm \
    ripgrep \
    ffmpeg \
    procps \
    wget \
    unzip \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*
ENV PATH="/root/.local/bin:$PATH"
RUN python3 -m pip install --upgrade pip
