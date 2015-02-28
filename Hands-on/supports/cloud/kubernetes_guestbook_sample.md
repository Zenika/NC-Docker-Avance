# Perform the before you begin
https://cloud.google.com/container-engine/docs/before-you-begin

# Install gcloud https://cloud.google.com/sdk/#Quick_Start
curl https://sdk.cloud.google.com | bash

# Enable preview features in the gcloud tool 
gcloud components update preview

# Tell the command line interface which Google Developers Console project to use
# project-ID can be found at https://console.developers.google.com/project
gcloud config set project western-emitter-825
gcloud config set compute/zone asia-east1-b

# Create the gke cluster (in this exemple we call it guestbook)
gcloud preview container clusters create guestbook

gcloud preview container clusters list
gcloud preview container clusters describe guestbook

# Start up the master pod defined by $CONFIG_DIR/redis-master-pod.json
gcloud preview container pods create \
    --config-file $CONFIG_DIR/redis-master-pod.json

gcloud preview container pods list


# Start up the redis master service defined by $CONFIG_DIR/redis-master-service.json
gcloud preview container services create \
    --config-file $CONFIG_DIR/redis-master-service.json 

# Create the redis worker replication controller defined by $CONFIG_DIR/redis-worker-controller.json with a redis worker podtemplate
gcloud preview container replicationcontrollers create \
    --config-file $CONFIG_DIR/redis-worker-controller.json

# Start up the redis worker service defined by $CONFIG_DIR/redis-woker-service.json
gcloud preview container services create \
    --config-file $CONFIG_DIR/redis-worker-service.json



# Start the PHP front-end
gcloud preview container replicationcontrollers create \
    --config-file $CONFIG_DIR/guestbook-controller.json

# Start up the PHTP front-end service
gcloud preview container services create \
    --config-file $CONFIG_DIR/guestbook-service.json

# Open the firewall port 3000
gcloud compute firewall-rules create guestbook-node-3000 --allow=tcp:3000 \
    --target-tags k8s-guestbook-node


alias machine="docker run --privileged -it  \
    -v /var/run/docker.sock:/var/run/docker.sock  \
    -v /root/.docker:/root/.docker --rm  \
    emilevauge/docker-cluster machine"

machine create --driver google --google-zone us-central1 -a gcp-machine
machine create --driver google --google-project proppy-stuff --google-zone us-central1-a gcp-machine






docker run --privileged -it -v /var/run/docker.sock:/var/run/docker.sock -v /root/.docker:/root/.docker --rm emilevauge/docker-cluster machine