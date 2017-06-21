FROM petrosagg/resin-wpe:raspberrypi3-17-04.01

COPY udev-rules/ /etc/udev/rules.d/

COPY wpe-init /wpe-init

CMD [ "/wpe-init" ]

COPY public_html /var/lib/public_html

ENV WPE_URL="file:///var/lib/public_html/index.html"

# Defines our working directory in container
WORKDIR /usr/src/app

# Copies the package.json first for better cache on later pushes
COPY package.json package.json

# This will copy all files in our root to the working  directory in the container
COPY . ./