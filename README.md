# WhatsApp Bot Auto Installer 🇮🇷

ربات آماده‌ برای ارسال پیام خودکار در واتساپ با استفاده از Docker و Node.js

---

## ✨ امکانات

- نصب خودکار با یک اسکریپت
- اتصال به واتساپ از طریق اسکن QR
- ارسال پیام با API ساده
- هماهنگ با وردپرس و سایر سایت‌ها
- مناسب برای سرورهای واقعی یا هاست‌های اشتراکی (با Pipedream)

---

## 📦 نصب سریع در سرور

```bash
wget https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/whatsapp-bot-installer/main/install-whatsapp-bot.sh
chmod +x install-whatsapp-bot.sh
./install-whatsapp-bot.sh
```

پس از نصب، با دستور زیر QR کد واتساپ را ببینید و اسکن کنید:

```bash
docker logs -f whatsapp
```

---

## 🔌 استفاده از API

```bash
curl -X POST http://YOUR-IP:3000/send \
-H "Content-Type: application/json" \
-d '{ "number": "09351234567", "message": "سلام! پیام تست ربات واتساپ 🚀" }'
```

---

## ☁️ اگر از هاست اشتراکی (مثلاً وردپرس) استفاده می‌کنید

چون هاست اشتراکی اجازه اتصال مستقیم به IP سرور را نمی‌دهد، می‌توانید از سایت [Pipedream.com](https://pipedream.com) استفاده کنید:

### نحوه استفاده:

1. وارد سایت [https://pipedream.com](https://pipedream.com) شوید
2. یک `HTTP Trigger` بسازید
3. در تنظیمات آن، خروجی را به آدرس `http://YOUR-IP:3000/send` فوروارد کنید (با `axios.post`)
4. در وردپرس به جای IP مستقیم، آدرس Pipedream را در `curl` یا `wp_remote_post` استفاده کنید

### مزایا:

- مناسب برای دور زدن محدودیت هاست اشتراکی
- بدون نیاز به دامنه یا SSL در سمت سرور

### محدودیت‌ها:

- ممکن است تأخیر داشته باشد
- برای استفاده حرفه‌ای مناسب نیست
- اگر بات در دسترس نباشد، پیام‌ها در Pipedream می‌مانند

---

## 🧠 ساختار فایل‌ها

```
.
├── index.js                # فایل اصلی ربات
├── Dockerfile              # فایل ساخت ایمیج داکر
├── install-whatsapp-bot.sh # اسکریپت نصب خودکار
├── docker-compose.yml      # اجرای سریع چندکانتینری
```

---

## ☕ ساخته شده توسط میلاد – [t.me/miliju](https://t.me/miliju)
