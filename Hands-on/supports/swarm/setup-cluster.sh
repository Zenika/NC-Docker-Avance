#!/bin/sh
# Setup a docker cluster
# inception mode (docker cluster in docker :-P), using jpetazzo/dind
set -e

log() {
    echo "$(tput setaf 2)>$(tput bold)>$(tput sgr0) $@"
}
warn() {
    echo "$(tput setaf 3)>$(tput bold)>$(tput sgr0) $@"
}
notice() {
    echo "$(tput setaf 6)<$(tput bold)<$(tput sgr0) $@"
}

. ../source-me

DEFAULT_LABELS="storage=disk"

docker images | grep dind || {
    log "download and build dind (because it was not present)"
    git clone https://github.com/jpetazzo/dind
    cd dind && docker build -t dind . && cd -
}

log "create a swarm cluster"
CLUSTER_ID=$(swarm create)
notice "Docker swarm cluster id : ${CLUSTER_ID}"

log "create some nodes"
for node in $(seq 4)
do
    ENGINE_PORT="2375${node}"
    LABELS="--label $DEFAULT_LABELS"
    NODE_NAME="dind-${ENGINE_PORT}"
    test $node == 2 && {
        LABELS="--label storage=ssd"
    }
    test $node == 3 && {
        LABELS="${LABELS} --label type=somuchpower"
    }
    notice "node ${node} : remove running one (if present)"
    docker stop "${NODE_NAME}" >/dev/null 2>/dev/null || true
    docker rm "${NODE_NAME}" >/dev/null 2>/dev/null || true
    notice "node ${node} : start a docker engine in docker on port ${ENGINE_PORT} with option : $LABELS"
    dind "${NODE_NAME}" $ENGINE_PORT "$LABELS"
    notice "node ${node} : wait for engine to startup (5s)"
    sleep 3
    NODE_IP=$(docker inspect $NODE_NAME | grep IPAddress | cut -d '"' -f 4)
    notice "node ${node} : join the swarm cluser as ${NODE_IP}:${ENGINE_PORT}"
    docker -H 127.0.0.1:${ENGINE_PORT} run -d swarm join --addr=${NODE_IP}:${ENGINE_PORT} token://${CLUSTER_ID}
done

log "start the swarm manager"
docker stop swarm-manager >/dev/null 2>/dev/null || true
docker rm swarm-manager >/dev/null 2>/dev/null || true
docker run --name "swarm-manager" -d -p 127.0.0.1:2385:2375 swarm manage token://${CLUSTER_ID}

# TLS error : https://docs.docker.com/articles/https/
# TODO ?
sleep 3
log "swarm info & list"
notice "info"
DOCKER_HOST=127.0.0.1:2385 docker info
notice "swarm list"
swarm list token://${CLUSTER_ID}

log "you can now play with your cluster"
log "- cluster : token://${CLUSTER_ID}"
log "- swarm manager (docker) : 127.0.0.1:2835"
warn "** Don't forget to set your ENV variable DOCKER_HOST to 127.0.0.1:2835 **"
warn "** export DOCKER_HOST=127.0.0.1:2385 **"
log "Enjoy ;-)"
