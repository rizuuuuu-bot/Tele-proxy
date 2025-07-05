FROM alpine:latest

# Install all required packages
RUN apk add --no-cache bash curl python3 nodejs npm

# Set working directory
WORKDIR /

# Copy files
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY healthcheck.py /healthcheck.py
COPY ping.js /ping.js
COPY package.json /package.json

# Fix permission
RUN chmod +x /docker-entrypoint.sh

# Install dependencies
RUN npm install

# Start everything
CMD /bin/sh -c "/docker-entrypoint.sh & python3 /healthcheck.py & node ping.js & wait"
