# WhatsApp Bot Auto Installer 🇮🇷

یک اسکریپت نصب خودکار برای راه‌اندازی ربات ارسال پیام واتساپ با استفاده از [whatsapp-web.js](https://github.com/pedroslopez/whatsapp-web.js) و Docker.

---

## ✨ امکانات

- اتصال خودکار به واتساپ با QR کد
- API ساده برای ارسال پیام به شماره‌های ایرانی (با فرمت 09...)
- نصب کامل بدون نیاز به تنظیم دستی
- اجرا در محیط امن Docker

---

## 📦 نحوه نصب

### 1. دانلود و اجرای اسکریپت

```bash
wget https://raw.githubusercontent.com/mil4d1/whatsapp-bot-installer/main/install-whatsapp-bot.sh
chmod +x install-whatsapp-bot.sh
./install-whatsapp-bot.sh
```

### 2. اسکن QR

بعد از اجرای اسکریپت:

```bash
docker logs -f whatsapp
```

و QR کد را با اپ واتساپ گوشی خود اسکن کنید ✅

---

## 🔌 استفاده از API

```bash
curl -X POST http://YOUR-SERVER-IP:3000/send \
-H "Content-Type: application/json" \
-d '{ "number": "09351234567", "message": "سلام! پیام تست ربات واتساپ 🚀" }'
```

---

## 📁 ساختار پروژه

```
.
├── index.js          ← فایل اصلی ربات
├── Dockerfile        ← فایل ساخت ایمیج داکر
└── install-whatsapp-bot.sh  ← اسکریپت نصب
```

---

## 🛠 پیش‌نیازها

- Ubuntu یا هر سرور لینوکسی با دسترسی root
- Docker

---

## ☕ توسط Milad ساخته شده – برای سوالات: [t.me/miliju](https://t.me/miliju)
