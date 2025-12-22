# settings
set dotenv-load := true

# list of available targets
@default:
    just --list --list-heading '' --list-prefix '  ' --unsorted

# create .env file
@env:
    [ -f "./.env" ] || cp -n ./.env.example ./.env

# build docker image
@build:
    docker build . --no-cache --file ./dockerfile --tag docker-dont-starve-together:latest --build-arg STEAM_USER=${STEAM_USER} --build-arg STEAM_PASS=${STEAM_PASS}
