FROM alpine
LABEL org.opencontainers.image.source="https://github.com/MultiVersion/nodexpython" org.opencontainers.image.source="https://multiversion.dviih.technology/" org.opencontainers.image.version="21.09" org.opencontainers.image.revision="Rolling" org.opencontainers.image.authors="Dviih" org.opencontainers.image.licenses="unlicense.org"
RUN apk add --update --no-cache bash python2 python3 py-pip libstdc++ gcc g++ make

# | NodeJS Install
ADD ./nodejs/nodejs12.tar.gz /opt/nodejs12
ADD ./nodejs/nodejs14.tar.gz /opt/nodejs14
ADD ./nodejs/nodejs16.tar.gz /opt/nodejs16

# | Entrypoint
ADD ./entrypoint.sh /entrypoint.sh

# | Framework
ADD ./shell/node /usr/bin/node
ADD ./shell/npm /usr/bin/npm
ADD ./shell/npx /usr/bin/npx
RUN \
  chmod +x /usr/bin/node && \
  chmod +x /usr/bin/npm && \
  chmod +x /usr/bin/npx && \
  chmod +x /entrypoint.sh && \
  adduser --disabled-password --home /home/container container
USER container
ENV  USER=container HOME=/home/container PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
WORKDIR /home/container

CMD ["/bin/bash","/entrypoint.sh"]