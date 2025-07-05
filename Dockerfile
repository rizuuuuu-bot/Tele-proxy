FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache bash curl python3 nodejs npm

WORKDIR /

# Copy all required files
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY healthcheck.py /healthcheck.py
COPY ping.js /ping.js
COPY package.json /package.json

# Set execution permissions
RUN chmod +x /docker-entrypoint.sh

# Install node dependencies
RUN npm install

# Start everything
CMD [ "sh", "-c", "/docker-entrypoint.sh & python3 /healthcheck.py & node ping.js" ]
