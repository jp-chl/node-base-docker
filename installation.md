
# Based on:
- https://jdlm.info/articles/2019/09/06/lessons-building-node-app-docker.html
- https://github.com/jdleesmiller/docker-chat-demo

`docker-compose run --rm chat bash                                  `
<pre>
Creating network "node-base-docker_default" with the default driver
Creating volume "node-base-docker_chat_node_modules" with default driver
node@534e155563b9:/srv/chat$ npm install --save express
npm WARN chat@1.0.0 No description

+ express@4.17.1
added 50 packages from 37 contributors and audited 50 packages in 3.364s
found 0 vulnerabilities
</pre>


<pre>
node@534e155563b9:/srv/chat$ ls -l
total 36
-rw-r--r--  1 node node  2732 Jul 27 17:16 Dockerfile
-rw-r--r--  1 node node   187 Jul 27 17:22 docker-compose.yml
-rw-r--r--  1 node node   457 Jul 27 17:26 installation.md
drwxr-xr-x 52 node node  4096 Jul 27 17:24 node_modules
-rw-r--r--  1 node node 14280 Jul 27 17:24 package-lock.json
-rw-r--r--  1 node node   521 Jul 27 17:24 package.json

node@534e155563b9:/srv/chat$ ls -l node_modules/
total 196
drwxr-xr-x 2 node node 4096 Jul 27 17:24 accepts
...
drwxr-xr-x 2 node node 4096 Jul 27 17:24 vary
</pre>

`docker-compose run --rm chat npm install --save socket.io@1        `
<pre>
npm WARN deprecated json3@3.3.2: Please use the native JSON object instead of JSON 3
npm WARN chat@1.0.0 No description

+ socket.io@1.7.4
added 52 packages from 37 contributors and audited 102 packages in 10.492s
found 9 vulnerabilities (8 low, 1 high)
  run `npm audit fix` to fix them, or `npm audit` for details
</pre>


`docker-compose run --rm chat npm install --save-dev nodemon           `
<pre>
Creating network "node-base-docker_default" with the default driver
Creating volume "node-base-docker_chat_node_modules" with default driver

> nodemon@2.0.4 postinstall /srv/chat/node_modules/nodemon
> node bin/postinstall || exit 0

Love nodemon? You can now support the project via the open collective:
 > https://opencollective.com/nodemon/donate

npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@~2.1.2 (node_modules/chokidar/node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.1.3: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})

+ nodemon@2.0.4
added 170 packages from 84 contributors and audited 221 packages in 8.797s
found 9 vulnerabilities (8 low, 1 high)
  run `npm audit fix` to fix them, or `npm audit` for details
</pre>