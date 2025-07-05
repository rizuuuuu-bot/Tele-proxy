# 🔹 Base Alpine image
FROM alpine:latest

# 🔹 Install bash, curl, python3 (for healthcheck)
RUN apk add --no-cache bash curl python3

# 🔹 Copy proxy entry script
COPY docker-entrypoint.sh /

# 🔹 Copy fake HTTP server for Render healthcheck
COPY healthcheck.py /

# 🔹 Start both: MTProto Proxy + Healthcheck server
CMD ["sh", "-c", "/docker-entrypoint.sh & python3 /healthcheck.py"]
