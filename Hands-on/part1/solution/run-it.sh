#!/bin/sh
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

# Initialize the workspace to be able to work
log "clone the sources"
test -d flask-by-example || git clone https://github.com/realpython/flask-by-example.git && notice "already done"

log "Let's build it"
fig build

log "Let's run it"
fig up
