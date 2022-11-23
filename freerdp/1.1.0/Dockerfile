FROM changel/ubuntu:18.04

#base setup
RUN set -ex \
    && apt update \
    && apt install -y freerdp-x11 \
    && rm -rf /var/lib/apt/lists/*

