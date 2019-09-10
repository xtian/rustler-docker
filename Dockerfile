FROM rust:1.37.0-slim as rust

FROM elixir:1.9.1
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    gcc libc6-dev make \
    wget curl
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH
COPY --from=rust /usr/local/cargo /usr/local/cargo
COPY --from=rust /usr/local/rustup /usr/local/rustup
RUN rm -Rf _build && \
    mix local.hex --force && \
    mix local.rebar --force
