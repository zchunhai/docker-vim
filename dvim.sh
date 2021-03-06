#!/bin/bash

function dvim() {
    docker ps --filter "name=dvim" | grep dvim
    if [ $? -ne 0 ]; then
        http_proxy=http://docker.for.mac.host.internal:1087
        docker run --rm --name dvim \
            -d -e http_proxy=$http_proxy -e https_proxy=$http_proxy \
            -v /etc/localtime:/etc/localtime:ro \
            -v ~/work:/home/hermit/work chunhai/docker-vim:latest
    fi

    docker exec -it dvim bash
}
