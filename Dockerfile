FROM alpine
RUN apk add --update --no-cache bash python2 python3 py-pip libstdc++ bash gcc g++ make cmake

# | NodeJS Install
RUN \ 
  wget https://unofficial-builds.nodejs.org/download/release/v14.9.0/node-v14.9.0-linux-x64-musl.tar.gz -O /tmp/nodejs14.tar.gz && \
  wget https://unofficial-builds.nodejs.org/download/release/v16.7.0/node-v16.7.0-linux-x64-musl.tar.gz -O /tmp/nodejs16.tar.gz && \
  wget https://unofficial-builds.nodejs.org/download/release/v12.22.5/node-v12.22.5-linux-x64-musl.tar.gz -O /tmp/nodejs12.tar.gz && \
  mkdir /opt/nodejs14 && \
  mkdir /opt/nodejs16 && \
  mkdir /opt/nodejs12 && \
  tar -xzvf /tmp/nodejs14.tar.gz -C /opt/nodejs14 --strip-components 1 && \
  tar -xzvf /tmp/nodejs16.tar.gz -C /opt/nodejs16 --strip-components 1 && \
  tar -xzvf /tmp/nodejs12.tar.gz -C /opt/nodejs12 --strip-components 1 && \
  rm /tmp/nodejs14.tar.gz && \
  rm /tmp/nodejs16.tar.gz && \
  rm /tmp/nodejs12.tar.gz

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