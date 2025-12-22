# Docker Dont Starve Together

Docker image for running a Dont Starve Together dedicated server with support for multi shard setups such as Forest and Caves, plus a dedicated service for updating mods.

This image is designed for Docker and Docker Compose with a focus on persistence, mod management, and easy maintenance.

## Features

- Dedicated Dont Starve Together server
- Forest and Cave shard support
- Persistent saves and mods via volumes
- Workshop UGC mod support
- Separate mod update service
- Simple configuration using command flags

## Requirements

- Docker or Docker Compose
- Dont Starve Together server token from Klei
- Open UDP ports on the host

## Recommended Setup

The recommended way to run this image is using Docker Compose with separate services for Forest, Cave, and mod updates.

### Example docker-compose.yml

```yaml
services:
  forest:
    image: m1kesk/docker-dont-starve-together:latest
    restart: unless-stopped
    ports:
      - 10888:10888/udp
      - 10999:10999/udp
      - 27016:27016/udp
    volumes:
      - /data/dst/save:/home/steam/dst/save
      - /data/dst/mods:/home/steam/dst/game/mods
      - /data/dst/ugc_mods:/home/steam/dst/game/ugc_mods
    command: >
      -skip_update_server_mods
      -ugc_directory /home/steam/dst/game/ugc_mods
      -persistent_storage_root /home/steam/dst
      -conf_dir save
      -cluster server
      -shard forest

  cave:
    image: m1kesk/docker-dont-starve-together:latest
    restart: unless-stopped
    ports:
      - 11000:10999/udp
      - 27017:27016/udp
    volumes:
      - /data/dst/save:/home/steam/dst/save
      - /data/dst/mods:/home/steam/dst/game/mods
      - /data/dst/ugc_mods:/home/steam/dst/game/ugc_mods
    command: >
      -skip_update_server_mods
      -ugc_directory /home/steam/dst/game/ugc_mods
      -persistent_storage_root /home/steam/dst
      -conf_dir save
      -cluster server
      -shard cave

  update:
    image: m1kesk/docker-dont-starve-together:latest
    restart: no
    command: |
      -only_update_server_mods
      -ugc_directory /home/steam/dst/game/ugc_mods
    volumes:
      - /data/dst/mods:/home/steam/dst/game/mods
      - /data/dst/ugc_mods:/home/steam/dst/game/ugc_mods
