FROM alpine
RUN apk add --update --no-cache bash python2 python3 py-pip libstdc++ gcc g++ make cmake

# | NodeJS Install
ADD ./nodejs/nodejs12.tar.gz /opt/nodejs12
ADD ./nodejs/nodejs14.tar.gz /opt/nodejs14
ADD ./nodejs/nodejs16.tar.gz /opt/nodejs16

# | Framework
ADD ./shell/node /usr/bin/node
ADD ./shell/npm /usr/bin/npm
ADD ./shell/npx /usr/bin/npx
RUN \
  chmod +x /usr/bin/node && \
  chmod +x /usr/bin/npm && \
  chmod +x /usr/bin/npx

RUN adduser --disabled-password --home /home/container container
USER container
ENV  USER=container HOME=/home/container PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/bin/bash","/entrypoint.sh"]