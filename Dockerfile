FROM debian:sid

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl build-essential ca-certificates firefox-esr \
    && rm -rf /var/lib/apt/lists

# installing rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV CARGO_HOME="/root/.cargo"
ENV PATH="/root/.cargo/bin:$PATH"

# installing commands
RUN cargo install wasm-pack \
    && cargo install wasm-bindgen-cli \
    && cargo install geckodriver

# disable sandbox for restricted environments
ENV MOZ_DISABLE_CONTENT_SANDBOX=1

CMD ["/root/.cargo/bin/wasm-pack", "test", "--headless", "--firefox"]
