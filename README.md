* Based on *:
- https://jdlm.info/articles/2019/09/06/lessons-building-node-app-docker.html
- https://github.com/jdleesmiller/docker-chat-demo

Usage:
`docker build . -t chat:latest`

`docker run --rm --detach --publish 3000:3000 chat:latest`