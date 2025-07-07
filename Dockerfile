FROM alexdoesh/mtproxy:latest

RUN apk add --no-cache bash curl python3 nodejs npm

WORKDIR /

COPY healthcheck.py /healthcheck.py
COPY ping.js /ping.js
COPY package.json /package.json
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh
RUN npm install

CMD [ "sh", "-c", "/docker-entrypoint.sh & python3 /healthcheck.py & node ping.js" ]
