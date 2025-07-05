const axios = require("axios");

const TARGET_URL = "https://tele-proxy.onrender.com/health"; // 👈 Health route

setInterval(async () => {
  try {
    await axios.get(TARGET_URL);
    console.log(`[✅] Ping sent to ${TARGET_URL}`);
  } catch (err) {
    console.log(`[❌] Ping failed: ${err.message}`);
  }
}, 5 * 60 * 1000); // Every 5 mins
