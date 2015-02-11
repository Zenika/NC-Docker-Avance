#!/usr/bin/env sh
# Run the slides using Docker and Grunt
test -d node_modules || {
    echo ">> npm install :-("
    docker run -it -v $PWD:/data --rm dockerfile/nodejs-bower-grunt npm install
}

echo ">> grunt ;-p"
docker run -it -v $PWD:/data --net=host --rm dockerfile/nodejs-bower-grunt grunt
