FROM dart:3.7.0 AS build
WORKDIR /app

# Copy the entire packages directory to have access to all dependencies
COPY packages/ /app/packages/

# Move to the server directory
WORKDIR /app/packages/iot_cloud_server

RUN sed -i 's/\\\\/\//g' pubspec_overrides.yaml

# Install dependencies
RUN dart pub get

# Compile the server executable
RUN dart compile exe bin/main.dart -o bin/server

FROM rust:slim AS builder

# Installare git oltre a cmake e build-essential
RUN apt-get update && apt-get install -y cmake build-essential git

WORKDIR /build
RUN git clone https://github.com/eclipse-zenoh/zenoh-c.git
WORKDIR /build/zenoh-c
RUN mkdir build && cd build && cmake .. && make

# Final stage
FROM alpine:latest

RUN apk add --no-cache libstdc++ libgcc

# Copia librerie costruite
COPY --from=builder /build/zenoh-c/target/release/libzenohc.so /usr/local/lib/zenoh/
COPY --from=builder /build/zenoh-c/target/release/libzenohc.a /usr/local/lib/zenoh/
COPY --from=builder /build/zenoh-c/include/ /usr/local/include/zenoh/

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Create directory for Zenoh libraries
RUN mkdir -p /usr/local/lib/zenoh
RUN mkdir -p /usr/local/include/zenoh

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable
COPY --from=build /app/packages/iot_cloud_server/bin/server server

# Copy configuration files and resources
COPY --from=build /app/packages/iot_cloud_server/config/ config/
COPY --from=build /app/packages/iot_cloud_server/web/ web/
COPY --from=build /app/packages/iot_cloud_server/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/packages/iot_cloud_server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command
ENTRYPOINT ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role --apply-migrations