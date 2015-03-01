#!/bin/bash
# Run the registry for everybody "locally" to use

mkdir storage
docker run \
       -v "$PWD"/storage:registry \
       -e SETTINGS_FLAVOR=local \
       -e STORAGE_PATH=/registry \
       -e CORS_ORIGINS="[\'*\']" \
       -p 5000:5000 \
       registry
