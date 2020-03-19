#!/bin/bash

set -e
# Exit on fail

bundle check || bundle install && bundle clean --force
# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.

# (yarn check --integrity && yarn check --verify-tree) || yarn install --frozen-lockfile

exec "$@"
# Finally call command issued to the docker service

