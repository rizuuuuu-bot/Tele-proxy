#!/bin/sh

set -e
mkdir -p /data

RANDOM=$(printf "%d" "0x$(head -c4 /dev/urandom | od -t x1 -An | tr -d ' ')")
[ -z "$WORKERS" ] && WORKERS=2
[ -z "$MTP_PORT" ] && MTP_PORT=443

echo "#### Telegram Proxy ####"

SECRET_CMD=""
if [ ! -z "$SECRET" ]; then
  echo "[+] Using the explicitly passed secret: '$SECRET'."
else
  SECRET="$(dd if=/dev/urandom bs=16 count=1 2>/dev/null | od -tx1 | head -n1 | cut -c9- | tr -d ' ')"
  echo "[+] No secret passed. Generated: $SECRET"
fi

if echo "$SECRET" | grep -qE '^[0-9a-fA-F]{32}$'; then
  SECRET="$(echo "$SECRET" | tr '[:upper:]' '[:lower:]')"
  SECRET_CMD="-S $SECRET"
  echo "$SECRET_CMD" > /data/secret_cmd
  echo "$SECRET" > /data/secret
else
  echo '[F] Bad secret format.'
  exit 1
fi

TAG_CMD=""
if [ ! -z "$TAG" ]; then
  TAG="$(echo "$TAG" | tr '[:upper:]' '[:lower:]')"
  TAG_CMD="-P $TAG"
fi

REMOTE_CONFIG=/data/proxy-multi.conf
REMOTE_SECRET=/data/proxy-secret

curl -s https://core.telegram.org/getProxyConfig -o ${REMOTE_CONFIG} || exit 2
curl -s https://core.telegram.org/getProxySecret -o ${REMOTE_SECRET} || exit 5

EXTERNAL_IP=$(curl -s -4 "https://digitalresistance.dog/myIp")
INTERNAL_IP=$(ip -4 route get 8.8.8.8 | awk '{print $7; exit}')

echo "[*] Secret: $SECRET"
echo "[*] tg://proxy?server=${EXTERNAL_IP}&port=${MTP_PORT}&secret=${SECRET}"
echo "[*] https://t.me/proxy?server=${EXTERNAL_IP}&port=${MTP_PORT}&secret=${SECRET}"

echo '[+] Starting proxy...'
exec /mtproxy/mtproto-proxy -p ${MTP_PORT} --aes-pwd ${REMOTE_SECRET} --user root ${REMOTE_CONFIG} --nat-info "$INTERNAL_IP:$EXTERNAL_IP" $SECRET_CMD $TAG_CMD
