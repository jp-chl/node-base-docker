# Official Docker image for the latest long term support (LTS) node release
FROM node:10.16.3

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

