# Docker-vim

## Build

```
http_proxy=http://docker.for.mac.host.internal:1081
docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=$http_proxy -t chunhai/docker-vim:latest .
```

## Usage

```
http_proxy=http://docker.for.mac.host.internal:1081
docker run --rm --name docker-vim -d -e http_proxy=$http_proxy -e https_proxy=$http_proxy -v ~/work:/home/hermit/work chunhai/docker-vim:latest
docker exec -it docker-vim bash
```
