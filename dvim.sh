#!/bin/bash

function dvim() {
    docker ps --filter "name=docker-vim" | grep docker-vim
    if [ $? -ne 0 ]; then
        http_proxy=http://docker.for.mac.host.internal:1087
        docker run --rm --name docker-vim \
            -d -e http_proxy=$http_proxy -e https_proxy=$http_proxy \
            -v /etc/localtime:/etc/localtime:ro \
            -v ~/work:/home/hermit/work chunhai/docker-vim:latest
    fi

    docker exec -it docker-vim bash
}
