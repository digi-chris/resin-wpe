FROM petrosagg/resin-wpe:raspberrypi3-17-04.01

COPY udev-rules/ /etc/udev/rules.d/

COPY wpe-init /wpe-init

CMD [ "/wpe-init" ]

COPY public_html /var/lib/public_html

ENV WPE_URL="file:///var/lib/public_html/index.html"