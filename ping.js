const axios = require('axios');

setInterval(() => {
  axios.get('https://tele-proxy.onrender.com:8080/healthz')
    .then(() => console.log("✅ Uptime ping successful"))
    .catch(() => console.log("⚠️ Uptime ping failed"));
}, 60000);
