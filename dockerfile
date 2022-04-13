FROM rust:1.59 as builder
WORKDIR /usr/src/myapp
COPY . .
RUN cargo build -p dmm-tools-cli --release

FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y pngcrush libc6 && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/myapp
COPY --from=builder /usr/src/myapp/target/release/dmm-tools  /usr/src/myapp/dmm-tools
ENTRYPOINT ["./dmm-tools"]
CMD ["help"]
