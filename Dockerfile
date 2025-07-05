FROM alpine:latest

# Install bash, curl, python3 and Node.js + npm
RUN apk add --no-cache bash curl python3 nodejs npm

# Copy scripts
COPY docker-entrypoint.sh /
COPY healthcheck.py /
COPY ping.js /
COPY package.json /

# 🔧 Install dependencies from package.json
RUN npm install

# Start everything
CMD ["sh", "-c", "/docker-entrypoint.sh & python3 /healthcheck.py & node ping.js"]
