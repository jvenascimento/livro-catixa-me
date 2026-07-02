const CACHE_NAME = 'livro-caixa-v2';
const urlsToCache = [
  './',
  './index.html',
  './manifest.json'
];

// Instala o Service Worker e salva os arquivos em cache
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        return cache.addAll(urlsToCache);
      })
  );
});

// Responde às requisições do App (intercepta para funcionar offline)
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Retorna o arquivo do cache se existir, senão baixa da rede
        return response || fetch(event.request);
      })
  );
});

// Atualiza o cache quando houver mudanças
self.addEventListener('activate', event => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
