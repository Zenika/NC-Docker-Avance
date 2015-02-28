# Windows Azure

## Perform the Setting up 
    # Generate a x509 certificate
    openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
    openssl pkcs12 -export -out mycert.pfx -in mycert.pem -name "My Certificate"
    openssl x509 -inform pem -in mycert.pem -outform der -out mycert.cer

## Create the docker host VM on azure cloud
    docker-machine create \
        -d azure \
        --azure-subscription-id="9c80e4ab-2766-4069-86af-ba87ad5ff8a4" \
        --azure-subscription-cert="/Users/mariolet/Playground/azurecerts/mycert.pem" \
        nc-azure-machine

## Enable inbound http connections
Add an HTTP endpoint for the VM instance nc-azure-machine (private port 80, public port 80)

## Point your docker client to the docker host VM
    $(docker-machine env nc-azure-machine)

## Run a sample container on google cloud 
    docker run -d -p 80:8080 zenika/nodejs-sample-app
    curl $(docker-machine ip nc-azure-machine)

## Delete the docker host VM on azure cloud
    docker-machine rm nc-azure-machine