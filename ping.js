const axios = require('axios');

setInterval(() => {
  axios.get('https://telegram-mtproxy.up.railway.app/healthz')
    .then(() => console.log("✅ Uptime ping successful"))
    .catch(() => console.log("⚠️ Uptime ping failed"));
}, 60000);
