# Stage 1: Build node dependencies
FROM node:18-alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install

# Stage 2: Final stage with mtproxy
FROM alexdoesh/mtproxy:latest

RUN apk add --no-cache bash curl python3 nodejs

WORKDIR /

COPY --from=builder /app/node_modules /node_modules
COPY healthcheck.py /healthcheck.py
COPY ping.js /ping.js
COPY package.json /package.json
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 443

CMD [ "sh", "-c", "/docker-entrypoint.sh & python3 /healthcheck.py & node ping.js" ]
