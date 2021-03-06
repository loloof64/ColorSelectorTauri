FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

# Dev tools
RUN apt-get update && apt-get install -y libwebkit2gtk-4.0-dev build-essential curl libssl-dev gnupg libdbus-1-dev

# Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get -y install nodejs

# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Tauri
RUN cargo install tauri-bundler --force
RUN cargo install tauri-cli --force

RUN npm install --unsafe-perm -g tauri

WORKDIR /root/app
