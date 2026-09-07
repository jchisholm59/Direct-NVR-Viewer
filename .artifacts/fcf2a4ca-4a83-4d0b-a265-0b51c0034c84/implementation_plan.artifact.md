# Implementation Plan - Dockerize Direct-NVR-Viewer

Enable `Direct-NVR-Viewer` to run as a Docker container, providing a consistent environment and easy deployment, similar to the `NetPatrol` project.

## User Review Required

> [!IMPORTANT]
> The Frigate configuration path is currently hardcoded to `/Users/jim/config.yml`. I will modify `server.js` to allow this path to be overridden via the `FRIGATE_CONFIG_PATH` environment variable. In the `docker-compose.yml`, I will provide a default mapping, but you may need to adjust the volume mount to point to your actual `config.yml`.

> [!NOTE]
> The Docker setup uses `network_mode: host` to allow the application to discover and communicate with other services on your network (like Frigate and MQTT) more easily, matching the configuration used in `NetPatrol`.

## Proposed Changes

### [Server]

#### [MODIFY] [server.js](file:///Users/jim/Direct-NVR-Viewer/server.js)
- Update `FRIGATE_CONFIG_PATH` to use `process.env.FRIGATE_CONFIG_PATH` if available.

### [Docker]

#### [NEW] [Dockerfile](file:///Users/jim/Direct-NVR-Viewer/Dockerfile)
- Use `node:20-slim` as the base image.
- Install necessary dependencies.
- Copy application files and install npm packages.
- Expose the default port (3010).

#### [NEW] [docker-compose.yml](file:///Users/jim/Direct-NVR-Viewer/docker-compose.yml)
- Define a service for `direct-nvr-viewer`.
- Set `network_mode: host` and `privileged: true`.
- Configure environment variables and volume mounts for persistence of settings and clips.

### [Documentation]

#### [MODIFY] [README.md](file:///Users/jim/Direct-NVR-Viewer/README.md)
- Add a "Running with Docker" section with instructions on how to build and start the container.

## Verification Plan

### Manual Verification
- Verify that the application starts successfully in a Docker container using `docker compose up --build`.
- Check logs to ensure it can read the Frigate configuration if mounted.
- Verify that the web UI is accessible on the configured port.
