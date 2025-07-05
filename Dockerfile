FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash curl python3 nodejs npm

# Copy files
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY ./healthcheck.py /healthcheck.py
COPY ./ping.js /ping.js
COPY ./package.json /package.json

# Give run permission
RUN chmod +x /docker-entrypoint.sh

# Install node dependencies
RUN npm install

# Start everything
CMD ["sh", "-c", "/docker-entrypoint.sh & python3 /healthcheck.py & node ping.js"]
