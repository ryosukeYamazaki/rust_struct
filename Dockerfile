FROM rust AS build
ENV APP_ROOT /src
WORKDIR $APP_ROOT
COPY . $APP_ROOT
ARG BUILD_VERSION=unknown
ARG BUILD_HASH=unknown
RUN cargo build --release

FROM gcr.io/distroless/base-debian11
COPY --from=build /src/target/release/rust_struct /bin
ENV PORT 8080
EXPOSE $PORT
ENTRYPOINT ["/bin/rust_struct"]