FROM alpine:latest

# 🔸 Install bash, curl, python3 and Node.js
RUN apk add --no-cache bash curl python3 nodejs npm

# 🔸 Copy proxy and healthcheck
COPY docker-entrypoint.sh /
COPY healthcheck.py /
COPY ping.js /

# 🔸 Install Axios
RUN npm install axios

# 🔸 Start proxy + health server + ping script
CMD ["sh", "-c", "/docker-entrypoint.sh & python3 /healthcheck.py & node ping.js"]
