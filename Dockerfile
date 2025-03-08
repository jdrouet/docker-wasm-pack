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

# install binaryen
ARG BINARYEN_VERSION=117
RUN set -eux; \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
    amd64) BINARYEN_ARCH=x86_64 ;; \
    arm64) BINARYEN_ARCH=aarch64 ;; \
    esac; \
    curl -L -o /tmp/binaryen-version_${BINARYEN_VERSION}-${BINARYEN_ARCH}-linux.tar.gz https://github.com/WebAssembly/binaryen/releases/download/version_${BINARYEN_VERSION}/binaryen-version_${BINARYEN_VERSION}-${BINARYEN_ARCH}-linux.tar.gz \
    && cd /usr/local && tar -xvf /tmp/binaryen-version_${BINARYEN_VERSION}-${BINARYEN_ARCH}-linux.tar.gz \
    && mv binaryen-version_${BINARYEN_VERSION} binaryen \
    && rm -rf /tmp/binaryen-version_${BINARYEN_VERSION}-${BINARYEN_ARCH}-linux.tar.gz \
    && ldconfig

# set environment variables for Binaryen
ENV PATH=/usr/local/binaryen/bin:$PATH
# ENV LD_LIBRARY_PATH="/usr/local/binaryen/lib:$LD_LIBRARY_PATH"
# ENV CPLUS_INCLUDE_PATH="/usr/local/binaryen/include:$CPLUS_INCLUDE_PATH"
# ENV CPATH="/usr/local/binaryen/include:$CPATH"

CMD ["/usr/local/cargo/bin/wasm-pack", "test", "--headless", "--firefox"]
