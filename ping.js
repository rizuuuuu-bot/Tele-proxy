const axios = require('axios');

setInterval(() => {
  axios.get('https://teleproxy-production.up.railway.app/healthz')
    .then(() => console.log("✅ Uptime ping successful"))
    .catch(() => console.log("⚠️ Uptime ping failed"));
}, 60000);
