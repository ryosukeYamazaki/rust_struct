# build
FROM ekidd/rust-musl-builder:latest AS build
ARG BUILD_VERSION=unknown
ARG BUILD_HASH=unknown

USER rust
ADD --chown=rust:rust . ./
RUN cargo build --release
# for debug
# RUN cargo build

# make deploy image
FROM scratch
COPY --from=build /home/rust/src/target/x86_64-unknown-linux-musl/release/rust_struct /bin/rust_struct
# for debug
# COPY --from=build /home/rust/src/target/x86_64-unknown-linux-musl/debug/rust_struct /bin/rust_struct
ENV PORT 8080
EXPOSE $PORT
ENTRYPOINT ["/bin/rust_struct"]