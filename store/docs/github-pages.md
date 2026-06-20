# GitHub Pages — Gizlilik Politikası

Gizlilik politikasını ücretsiz statik hosting ile yayınlamak için GitHub Actions kullanılır.

## URL formatı

Repo adı `baby-sleep-sounds`, kullanıcı `KULLANICI` ise:

```
https://KULLANICI.github.io/baby-sleep-sounds/privacy-policy.html
```

App Store **Privacy Policy URL** ve Play Console **Privacy policy** alanına bu linki girin.

## Tek seferlik GitHub ayarı

1. Repoyu GitHub'a push edin
2. **Settings → Pages**
3. **Build and deployment → Source:** `GitHub Actions`
4. `main` (veya `master`) branch'e push yapın — workflow otomatik çalışır

## Workflow

Dosya: [`.github/workflows/pages.yml`](../../.github/workflows/pages.yml)

- `store/legal/` klasörünü yayınlar
- `store/legal/**` veya workflow değişince tetiklenir
- Manuel çalıştırma: **Actions → Deploy Privacy Policy → Run workflow**

## Yerel önizleme

```bash
cd store/legal
python3 -m http.server 8080
# http://localhost:8080/privacy-policy.html
```

## İçerik güncelleme

1. `store/legal/privacy-policy.html` veya `.md` dosyalarını düzenleyin
2. İletişim e-postası mağaza formlarında: **alperttungir@gmail.com**
3. `main` branch'e push edin
4. 1–2 dakika sonra Pages URL'si güncellenir

## Özel domain (isteğe bağlı)

Settings → Pages → Custom domain → DNS CNAME kaydı ekleyin.

## Sorun giderme

| Sorun | Çözüm |
|-------|--------|
| 404 | Pages Source'un "GitHub Actions" olduğundan emin olun |
| Workflow fail | Actions sekmesinde logları kontrol edin |
| Eski içerik | Hard refresh (Ctrl+Shift+R) veya birkaç dakika bekleyin |

## Metadata'da URL güncelleme

`store/play-store/metadata.yaml` ve `store/app-store/metadata.yaml` içinde:

```yaml
privacy_policy_url: "https://KULLANICI.github.io/baby-sleep-sounds/privacy-policy.html"
support_url: "https://KULLANICI.github.io/baby-sleep-sounds/"
```

`KULLANICI` ve repo adını kendi değerlerinizle değiştirin.
