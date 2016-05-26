#!/bin/bash

# Abort on error
set -e

# Generate config file from template
erb config/gdash.yaml.erb >config/gdash.yaml

# Run command under dumb-init, replacing shell
exec dumb-init -c "$@"
