FROM debian:sid

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl build-essential ca-certificates firefox-esr \
    && rm -rf /var/lib/apt/lists

# installing rust
ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=/usr/local/cargo/bin:$PATH
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# installing commands
RUN cargo install wasm-pack \
    && cargo install wasm-bindgen-cli \
    && cargo install geckodriver

# disable sandbox for restricted environments
ENV MOZ_DISABLE_CONTENT_SANDBOX=1

CMD ["/usr/local/cargo/bin/wasm-pack", "test", "--headless", "--firefox"]
