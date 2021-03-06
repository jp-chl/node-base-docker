# Official Docker image for the latest long term support (LTS) node release
FROM node:10.16.3 AS development

# These commands we need to run as root,
# create the working directory and make sure that it’s owned by the node user
#
# Commands are chained, so it reduces the number of layers in the resulting image
# (It can save a lot of disk space and download time)
RUN mkdir /srv/chat && chown node:node /srv/chat

# The USER step tells Docker to run any subsequent build steps, and later the process in the container,
# as the node user, which is an unprivileged user that comes built into all of the official node images
# from Docker. Without this line, they would run as root, which is against security best practices and
# in particular the principle of least privilege. Many Docker tutorials skip this step for simplicity,
# and we will have to do some extra work to avoid running as root, but I think it’s very important.
USER node

# The WORKDIR step sets the working directory for any subsequent build steps, and later for containers 
# created from the image, to /srv/chat, which is where we’ll put our application files. The /srv folder 
# should be available on any system that follows the Filesystem Hierarchy Standard, which says that it 
# is for “site-specific data which is served by this system”, which sounds like a good fit for a node app
WORKDIR /srv/chat

# The COPY to ./ copies the npm packaging files to the WORKDIR that we set up above.
# The trailing / tells Docker that the destination is a folder.
# The reason for copying in only the packaging files, rather than the whole application folder,
# is that Docker will cache the results of the npm install step below and rerun it only
# if the packaging files change. If we copied in all our source files,
# changing any one would bust the cache even though the required packages had not changed,
# leading to unnecessary npm installs in subsequent builds.
#
# The --chown=node:node flag for COPY ensures that the files are owned by the unprivileged
# node user rather than root, which is the default
COPY --chown=node:node package.json package-lock.json ./

# The npm install step will run as the node user in the working directory to
# install the dependencies in /srv/chat/node_modules inside the container
RUN npm install --quiet


# The npm install is what we want, but it causes a problem in development when we bind mount the application
#  folder on the host over /srv/chat. Unfortunately, the node_modules folder doesn’t exist on the host,
# so the bind effectively hides the node modules that we installed in the image.
# The final mkdir -p node_modules step and the next section are related to how we deal with this

# TODO: It can be removed once in we have some dependencies in package.json
RUN mkdir -p node_modules

# --------------
# Docker provide a powerful tool that helps with all of the above: multi-stage
# builds. The main idea is that we can have multiple FROM commands in the 
# Dockerfile, one per stage, and each stage can copy files from previous stages
FROM node:10.16.3-slim AS production

USER node

# We have to repeat the WORKDIR, because it doesn’t persist into the second stage automatically
WORKDIR /srv/chat

# The multi-stage Dockerfile runs npm install in the first stage, which has the full node image at
# its disposal for the build. Then it copies the resulting node_modules folder to the second stage image,
# which uses the slim base image. This technique reduces the size of the production image from 909MB to 152MB,
# which is about a factor of 6 saving for relatively little effort
#
# The COPY --from=development --chown=root:root ... line copies the dependencies installed in the preceding 
# development stage into the production stage and makes them owned by root,
# so the node user can read but not write them
COPY --from=development --chown=root:root /srv/chat/node_modules ./node_modules

# The COPY . . line then copies the rest of the application files from the host to the working directory
# in the container, namely /srv/chat
COPY . .

# Finally, the CMD step specifies the command to run. In the development stage, the application files came from bind 
# mounts set up with docker-compose, so it made sense to specify the command in the docker-compose.yml file instead of 
# the Dockerfile. Here it makes more sense to specify the command in the Dockerfile, which builds it into the container
CMD ["node", "index.js"]

