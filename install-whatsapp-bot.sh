#!/bin/bash

# رنگ‌ها
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 شروع نصب ربات واتساپ در Docker...${NC}"

# نصب git و docker اگر لازم باشد
apt update -y
apt install -y git docker.io

# پوشه پروژه
mkdir -p /opt/whatsapp-bot
cd /opt/whatsapp-bot

# ساخت فایل index.js
cat > index.js << 'EOF'
const { Client, LocalAuth } = require('whatsapp-web.js');
const express = require('express');
const bodyParser = require('body-parser');
const qrcode = require('qrcode-terminal');

const app = express();
app.use(bodyParser.json());

let isReady = false;

const client = new Client({
  authStrategy: new LocalAuth({ dataPath: "./.wwebjs_auth" }),
  puppeteer: {
    headless: true,
    executablePath: '/usr/bin/google-chrome-stable',
    args: [
      '--no-sandbox',
      '--disable-setuid-sandbox',
      '--disable-dev-shm-usage',
      '--disable-gpu',
      '--disable-extensions'
    ]
  }
});

client.initialize();

client.on('qr', (qr) => {
  console.log('📸 لطفاً QR را اسکن کن:');
  qrcode.generate(qr, { small: true });
});

client.on('ready', () => {
  isReady = true;
  console.log('✅ ربات واتساپ آماده است و در حال اجراست!');
});

client.on('disconnected', (reason) => {
  isReady = false;
  console.error('🔌 ربات قطع شد:', reason);
});

function normalizeNumber(number) {
  if (/^0\d{10}$/.test(number)) {
    return '+98' + number.substring(1);
  }
  return null;
}

app.post('/send', async (req, res) => {
  const { number, message } = req.body;
  console.log('📥 درخواست جدید:', req.body);

  if (!isReady) {
    return res.status(503).send({ error: 'ربات هنوز آماده نیست.' });
  }

  if (!number || !message) {
    return res.status(400).send({ error: 'شماره یا پیام ناقص است.' });
  }

  const normalized = normalizeNumber(number);
  if (!normalized) {
    return res.status(400).send({ error: 'فرمت شماره معتبر نیست.' });
  }

  const chatId = `${normalized.replace('+', '')}@c.us`;
  console.log("📤 شماره نهایی برای ارسال:", chatId);

  try {
    await client.sendMessage(chatId, message);
    console.log('✅ پیام ارسال شد به:', chatId);
    res.send({ status: 'success', message: 'پیام با موفقیت ارسال شد.' });
  } catch (err) {
    console.error('❌ خطا در ارسال پیام:', err.message);
    res.status(500).send({ status: 'error', message: err.message });
  }
});

app.listen(3000, '0.0.0.0', () => {
  console.log('🌐 API روی پورت 3000 در حال اجراست.');
});
EOF

# ساخت Dockerfile
cat > Dockerfile << 'EOF'
FROM node:18

WORKDIR /app
COPY . .

RUN npm install
CMD ["xvfb-run", "-a", "node", "index.js"]
EOF

# ساخت docker image
docker build -t whatsapp-bot .

# حذف کانتینر قبلی اگر وجود دارد
docker stop whatsapp || true
docker rm whatsapp || true

# اجرای کانتینر
docker run -d --name whatsapp -p 3000:3000 --restart unless-stopped whatsapp-bot

echo -e "${GREEN}✅ نصب کامل شد. اسکن QR را در لاگ ببینید با:${NC} docker logs -f whatsapp"
