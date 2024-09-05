# =====================================================
# Build-only image used to download the Factorio server
# =====================================================
FROM ubuntu:latest AS download

ARG version=latest
ARG build_date

WORKDIR /opt/factorio

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl xz-utils ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sL https://www.factorio.com/get-download/${version}/headless/linux64 | tar -xJ --strip-components=1

# ==========================
# Resulting distroless image
# ==========================
FROM gcr.io/distroless/base-nossl

ARG version=latest
ARG build_date

LABEL maintainer="Ryan Hartman <ryan@rhartman.dev>"
LABEL dev.rhartman.version=${version}
LABEL dev.rhartman.build_date=${build_date}


COPY --from=download /opt/factorio /opt/factorio

ENTRYPOINT ["/opt/factorio/bin/x64/factorio"]
