# Amazon

## Perform the Setting up with Amazon EC2
http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html (optional)
I've exported variables AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_VPC_ID in .bash_profile

## Create the docker host VM on amazon cloud
    docker-machine create -d amazonec2 \
    --amazonec2-access-key $AWS_ACCESS_KEY_ID \
    --amazonec2-secret-key $AWS_SECRET_ACCESS_KEY \
    --amazonec2-vpc-id $AWS_VPC_ID \
    --amazonec2-region eu-central-1 \
    --amazonec2-zone b \
    nc-amazonec2-machine

## Point your docker client to the docker host VM
    $(docker-machine env nc-amazonec2-machine)

## Enable inbound http connections
    Create a new security group that allow any connection HTTP/TCP on port 80
    Update the networking settings of the machine and add this new security group

## Run a sample container on google cloud (you should probably aws-enable http traffic from the web console)
    docker run -d -p 80:8080 zenika/nodejs-sample-app
    curl $(docker-machine ip nc-amazonec2-machine)

## Delete the docker host VM on amazon cloud
    docker-machine rm nc-amazonec2-machine