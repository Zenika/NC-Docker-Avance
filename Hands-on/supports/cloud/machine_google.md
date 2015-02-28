# Google

## Perform the before you begin (without installing gcloud)
https://cloud.google.com/container-engine/docs/before-you-begin

## Create the docker host VM on google cloud 
    docker-machine create --google-project "western-emitter-825" --driver google --google-zone "asia-east1-c" nc-google-machine

## Point your docker client to the docker host VM
    $(docker-machine env nc-google-machine)

## Enable inbound http connections
On the Compute Engine VM instances page select nc-google-machine and check 'Allow HTTP traffic' in the network section

## Run a sample container on google cloud (you should probably enable http traffic from the web console)
    docker run -d -p 80:8080 zenika/nodejs-sample-app
    curl $(docker-machine ip nc-google-machine)

## Delete the docker host VM on google cloud
    docker-machine rm nc-google-machine 