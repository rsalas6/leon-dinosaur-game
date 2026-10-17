#!/bin/sh
# Builds site/index.html (full page, installable as an app) from dino-race.html
set -e
cd "$(dirname "$0")"
VERSION=$(date +%Y%m%d%H%M%S)
{
  printf '<!doctype html>\n<html lang="es">\n<head>\n<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">\n'
  printf '<meta name="apple-mobile-web-app-capable" content="yes">\n<meta name="mobile-web-app-capable" content="yes">\n'
  printf '<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">\n<meta name="apple-mobile-web-app-title" content="Dino Race">\n'
  printf '<meta name="theme-color" content="#9ee8d6">\n<meta name="description" content="Carrera 3D de dinosaurios: cambia de dino según el terreno y llega primero.">\n'
  printf '<link rel="manifest" href="manifest.webmanifest">\n<link rel="apple-touch-icon" href="icons/apple-touch-icon.png">\n<link rel="icon" type="image/png" href="icons/icon-192.png">\n'
  sed -n '1,/^<\/style>$/p' dino-race.html | grep -v 'claude:viewport-fit-sides'
  printf '</head>\n<body>\n'
  sed '1,/^<\/style>$/d' dino-race.html
  printf "<script>if('serviceWorker' in navigator&&location.protocol==='https:')navigator.serviceWorker.register('sw.js');</script>\n"
  printf '</body>\n</html>\n'
} > site/index.html
sed "s/__VERSION__/$VERSION/" sw.template.js > site/sw.js
echo "site/ ready (version $VERSION)"
