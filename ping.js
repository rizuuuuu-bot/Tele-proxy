const axios = require('axios');

setInterval(() => {
  axios.get('https://tele-proxy.onrender.com:10000/health')
    .then(() => console.log("✅ Uptime ping successful"))
    .catch(() => console.log("⚠️ Uptime ping failed"));
}, 60000);
