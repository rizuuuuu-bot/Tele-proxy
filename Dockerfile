# Multi-stage build: node for ping.js, alpine for mtproxy

FROM node:18-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install

FROM alexdoesh/mtproxy:latest

RUN apk add --no-cache bash curl python3

WORKDIR /

COPY --from=builder /app/node_modules /node_modules
COPY ping.js /ping.js
COPY healthcheck.py /healthcheck.py
COPY package.json /package.json
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

# Expose healthcheck port & mtproxy port
EXPOSE 8080

CMD ["sh", "-c", "/docker-entrypoint.sh & python3 /healthcheck.py & node ping.js"]
