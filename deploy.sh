#!/bin/bash
set -e

echo "==> Pulling latest changes from git..."
git pull origin main

echo "==> Installing dependencies..."
npm install

echo "==> Building app..."
npm run build

echo "==> Ensuring upload directories exist..."
mkdir -p public/uploads/products
mkdir -p public/uploads/videos

echo "==> Restarting app..."
if command -v pm2 &> /dev/null; then
  pm2 restart all
  echo "==> Done! App restarted with PM2."
elif systemctl is-active --quiet dopik 2>/dev/null; then
  systemctl restart dopik
  echo "==> Done! App restarted with systemctl."
else
  echo "==> Build complete. Restart your app manually (pm2 restart / systemctl restart)."
fi
