#!/bin/bash
log() {
    echo "$(tput setaf 2)>$(tput bold)>$(tput sgr0) $@"
}
warn() {
    echo "$(tput setaf 3)>$(tput bold)>$(tput sgr0) $@"
}
notice() {
    echo "$(tput setaf 6)<$(tput bold)<$(tput sgr0) $@"
}

# Exit on error
set -e

. ../../supports/source-me

# Initialize the workspace to be able to work
log "clone the sources"
test -d app/flask-by-example || git clone https://github.com/realpython/flask-by-example.git app/flask-by-example && notice "already done"

log "Let's build it"
docker-compose build

log "Let's run it"
docker-compose up
