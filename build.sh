#!/bin/sh
# Builds site/ (full page, installable as an app, works 100% offline) from dino-race.html
set -e
cd "$(dirname "$0")"
VERSION=$(date +%Y%m%d%H%M%S)
rm -rf site/vendor && mkdir -p site/vendor && cp -R vendor/ site/vendor/
{
  printf '<!doctype html>\n<html lang="es">\n<head>\n<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">\n'
  printf '<meta name="apple-mobile-web-app-capable" content="yes">\n<meta name="mobile-web-app-capable" content="yes">\n'
  printf '%s\n' '<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">' "<meta name=\"apple-mobile-web-app-title\" content=\"Leon's Dinos\">"
  printf '<meta name="theme-color" content="#9ee8d6">\n<meta name="description" content="Leon'"'"'s Dinosaur Game: a 3D dinosaur race. Switch dinos to match the terrain and win.">\n'
  printf '<link rel="manifest" href="manifest.webmanifest">\n<link rel="apple-touch-icon" href="icons/apple-touch-icon.png">\n<link rel="icon" type="image/png" href="icons/icon-192.png">\n'
  sed -n '1,/^<\/style>$/p' dino-race.html | grep -v 'claude:viewport-fit-sides' | grep -v 'rel="preconnect"' \
    | sed 's#<link rel="stylesheet" href="https://fonts.googleapis.com[^"]*">#<link rel="stylesheet" href="vendor/fonts.css">#'
  printf '</head>\n<body>\n'
  sed '1,/^<\/style>$/d' dino-race.html \
    | sed 's#https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js#vendor/three.min.js#'
  printf "<script>if('serviceWorker' in navigator&&location.protocol==='https:')navigator.serviceWorker.register('sw.js');</script>\n"
  printf '</body>\n</html>\n'
} > site/index.html
# Every file in site/ is cached on the device on first visit
FILES=$(cd site && find . -type f ! -name 'sw.js' ! -name '_headers' ! -name '_test.html' ! -name '.DS_Store' | sed 's#^\./##' | sort | awk '{printf "%s\x27%s\x27", (NR>1?", ":""), $0}')
sed -e "s/__VERSION__/$VERSION/" -e "s#__FILES__#'./', $FILES#" sw.template.js > site/sw.js
if grep -q 'googleapis\|cdnjs' site/index.html; then echo "ERROR: external URL left in site/index.html"; exit 1; fi
echo "site/ ready (version $VERSION)"
