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
        test -e postgres.tar.xz && docker load --input postgres.tar.xz || docker pull postgres
        test -e redis.tar && docker load --input redis.tar.xz || docker pull redis
        test -e zenika_nc-avance-solution.tar.xz && docker load import --input zenika_nc-avance-solution.tar.xz || docker pull zenika/nc-avance-solution
    }
}

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
