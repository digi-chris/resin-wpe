FROM petrosagg/resin-wpe:raspberrypi3-17-04.01

COPY udev-rules/ /etc/udev/rules.d/

COPY wpe-init /wpe-init

CMD [ "/wpe-init" ]

RUN apt-get install -y nodejs npm

COPY public_html /var/lib/public_html

ENV WPE_URL="file:///var/lib/public_html/index.html"

# Defines our working directory in container
WORKDIR /usr/src/app

# Copies the package.json first for better cache on later pushes
COPY package.json package.json

# This install npm dependencies on the resin.io build server,
# making sure to clean up the artifacts it creates in order to reduce the image size.
RUN JOBS=MAX npm install --production --unsafe-perm && npm cache clean && rm -rf /tmp/*

# This will copy all files in our root to the working  directory in the container
COPY . ./

# Enable systemd init system in container
ENV INITSYSTEM on

# server.js will run when container starts up on the device
CMD ["npm", "start"]