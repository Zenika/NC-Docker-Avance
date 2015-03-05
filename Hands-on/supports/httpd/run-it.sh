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

save_image() {
    image=$1
    shift
    file=$1
    test -e storage/$file.tar.xz || {
        notice "save $image to storage/$file.tar.xz"
        docker save --output storage/$file.tar $image
        xz storage/$file.tar
    }
}

log "Set up storage"
test -d storage || mkdir -p storage

log "Save and compress images"
save_image redis redis
save_image postgres postgres
save_image zenika/nc-avance-solution zenika_nc-avance-solution

docker run --name nginx -p 80:80 -v "${PWD}/storage":/usr/share/nginx/html:ro -d nginx
