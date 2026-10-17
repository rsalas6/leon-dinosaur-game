// Caches the whole game on the device so it works 100% offline after the first visit
const CACHE = 'leons-dinosaur-game-20261017084401';
const FILES = ['./', 'icons/apple-touch-icon.png', 'icons/icon-192.png', 'icons/icon-512.png', 'index.html', 'manifest.webmanifest', 'vendor/fonts.css', 'vendor/fonts/XRXV3I6Li01BKofINeaBTMnFcQ.woff2', 'vendor/fonts/XRXV3I6Li01BKofIO-aBTMnFcQIG.woff2', 'vendor/fonts/i7dPIFZ9Zz-WBtRtedDbYE98RXi4EwSsbg.woff2', 'vendor/fonts/i7dPIFZ9Zz-WBtRtedDbYEF8RXi4EwQ.woff2', 'vendor/three.min.js'];
self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(FILES)).then(() => self.skipWaiting()));
});
self.addEventListener('activate', e => {
  e.waitUntil(caches.keys().then(ks => Promise.all(ks.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => self.clients.claim()));
});
self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET' || new URL(req.url).origin !== location.origin) return;
  // Page: network first (to pick up updates), cached copy when offline
  if (req.mode === 'navigate') {
    e.respondWith(fetch(req).then(r => { const c = r.clone(); caches.open(CACHE).then(ca => ca.put('index.html', c)); return r; })
      .catch(() => caches.match('index.html')));
    return;
  }
  // Everything else: cached copy first
  e.respondWith(caches.match(req, { ignoreSearch: true }).then(hit => hit || fetch(req)));
});
