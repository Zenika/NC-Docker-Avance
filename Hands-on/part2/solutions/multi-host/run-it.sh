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

. ../../../source-me

create_machine() {
    NODE_NAME=$1
    shift
    SWARM_CLUSTER_ID=$1
    docker-machine ls | grep ${NODE_NAME} || {
        docker-machine create -d virtualbox --virtualbox-disk-size '6000' --virtualbox-memory '512' --swarm --swarm-discovery=token://${SWARM_CLUSTER_ID} ${NODE_NAME}
        $(docker-machine env ${NODE_NAME})
        docker pull postgres
        docker pull redis
        docker pull zenika/nc-avance-solution
    }
}


#docker-machine ls | grep registry || {
#    log "Create registry"
#    docker-machine create -d virtualbox --virtualbox-disk-size '4500' --virtualbox-memory '256' registry
#    $(docker-machine env registry)
#    notice ".. wating 3s to docker engine to start"
#    wait 3
#    REGISTRY_IP=$(docker-machine ip registry)
#    docker run -d -e SETTINGS_FLAVOR=local \
#       -e STORAGE_PATH=/registry \
#       -e CORS_ORIGINS="[\'*\']" \
#       -p 5000:5000 registry
#    unset DOCKER_CERT_PATH
#    unset DOCKER_HOST
#    unset DOCKER_TLS_VERIFY
#    notice ".. waiting 5s to registry to start"
#    docker tag postgres ${REGISTRY_IP}:5000/postgres
#    docker push ${REGISTRY_IP}:5000/postgres
#    docker tag redis ${REGISTRY_IP}:5000/redis
#    docker push ${REGISTRY_IP}:5000/redis
#    docker tag zenika/nc-avance-solution ${REGISTRY_IP}:5000/zenika/nc-avance-solution
#    docker push ${REGISTRY_IP}:5000/zenika/nc-avance-solution
#}

docker-machine ls | grep swarm-master || {
    log "Create the swarm cluster"
    CLUSTER_ID=$(swarm create)
    notice "cluster id : ${CLUSTER_ID}"
    docker-machine create -d virtualbox --virtualbox-disk-size '3000' --virtualbox-memory '256' --swarm --swarm-master --swarm-discovery=token://${CLUSTER_ID} swarm-master
}

log "Create the node machines"
create_machine node1 ${CLUSTER_ID}
create_machine node2 ${CLUSTER_ID}
create_machine node3 ${CLUSTER_ID}
create_machine node4 ${CLUSTER_ID}

log "Setup environment variables"
$(docker-machine env --swarm swarm-master)

log "Clone the sources"
test -d flask-by-example || git clone https://github.com/vdemeester/flask-by-example.git && notice "already done"

#log "Let's build it"
#docker-compose build

log "Run a shell"
notice "You can now play with docker-compose, it will point on the swarm engine"
bash
