# Docker `wasm-pack`

A Docker image for building and testing WebAssembly projects using wasm-pack with Firefox headless testing support.

## Features

- Based on Debian Sid
- Includes Rust toolchain with wasm-pack and wasm-bindgen-cli
- Firefox ESR and geckodriver for headless testing
- Chromium and Chromium Web Driver
- Binaryen tools for WebAssembly optimization
- Weekly automated builds

## Usage

### Pull the image

```bash
docker pull jdrouet/wasm-pack:latest
```

### Basic Usage

Run tests in your Rust/WebAssembly project:

```bash
docker run -v $(pwd):/code -w /code jdrouet/wasm-pack:latest
```

### Custom Commands

You can override the default test command:

```bash
docker run -v $(pwd):/code -w /code jdrouet/wasm-pack:latest wasm-pack build
```

## Available Tags

- `latest`: Most recent build
- `weekly`: Updated every Wednesday
- `YYYY-MM-DD`: Date-stamped versions

## Included Tools

- Rust (latest stable)
- wasm-pack
- wasm-bindgen-cli
- geckodriver
- Firefox ESR
- Binaryen (version 117)

## Environment Variables

- `MOZ_DISABLE_CONTENT_SANDBOX=1`: Firefox sandbox disabled for containerized environments
- Standard Rust environment variables (`RUSTUP_HOME`, `CARGO_HOME`)
- Binaryen added to system PATH

## Building Locally

```bash
docker build -t wasm-pack .
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Notes

- The image is automatically built and pushed to Docker Hub every Wednesday at 4:00 UTC
- Currently supports linux/amd64 platform
- Includes support for both amd64 and arm64 architectures for Binaryen tools
