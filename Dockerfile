FROM ubuntu:latest

ARG version=latest

WORKDIR /opt/factorio

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl xz-utils ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sL https://www.factorio.com/get-download/$version/headless/linux64 | tar -xJ --strip-components=1

ENTRYPOINT ["/opt/factorio/bin/x64/factorio"]
