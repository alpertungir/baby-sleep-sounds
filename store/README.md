# Mağaza Metadata — Bebek Uyku Sesleri

Google Play ve App Store listeleri için hazır metinler, gizlilik politikası ve ekran görüntüsü rehberi.

## Hızlı kopyala-yapıştır

| Alan | Dosya |
|------|--------|
| Google Play TR/EN açıklama | [`play-store/listing-tr.md`](play-store/listing-tr.md) |
| App Store TR/EN açıklama | [`app-store/listing-tr.md`](app-store/listing-tr.md) |
| Kısa alanlar (başlık, anahtar kelime) | [`play-store/metadata.yaml`](play-store/metadata.yaml), [`app-store/metadata.yaml`](app-store/metadata.yaml) |
| Sürüm notları 2.0.0 | [`release-notes/2.0.0-tr.txt`](release-notes/2.0.0-tr.txt) |
| Gizlilik politikası | [`legal/privacy-policy-tr.md`](legal/privacy-policy-tr.md) |
| Ekran görüntüsü boyutları | [`screenshots/GUIDE.md`](screenshots/GUIDE.md) |
| Yayın kontrol listesi | [`CHECKLIST.md`](CHECKLIST.md) |

## Dağıtım rehberleri

| Konu | Rehber |
|------|--------|
| Android release imzalama | [`docs/android-signing.md`](docs/android-signing.md) |
| iOS release imzalama | [`docs/ios-signing.md`](docs/ios-signing.md) |
| GitHub Pages (gizlilik URL) | [`docs/github-pages.md`](docs/github-pages.md) |

## Yayınlamadan önce güncelleyin

1. **Destek e-postası:** alperttungir@gmail.com
2. **Gizlilik URL:** `https://alpertungir.github.io/baby-sleep-sounds/privacy-policy.html`
3. **Android imzalama:** `cd app && ./scripts/setup-android-signing.sh`
4. **Firebase Android uygulaması:** Paket `com.tngrstudio.babysleepsounds` — aşağıdaki adımlar
5. **iOS imzalama:** `cd app && ./scripts/setup-ios-signing.sh` (macOS)

### Firebase (yeni paket adı)

Eski `com.alfaapps.BabySleepSounds` kaydını silmek zorunda değilsin; yeni Android uygulaması ekle:

1. [Firebase Console](https://console.firebase.google.com/) → proje `baby-sleep-sounds-482b5`
2. **Add app → Android** → paket: `com.tngrstudio.babysleepsounds`
3. SHA-1 (release): `keytool -list -v -keystore app/android/upload-keystore.jks -alias upload`
4. İndirilen `google-services.json` → `app/android/app/google-services.json` (üzerine yaz)
5. Storage kurallarını tekrar **Publish** et (`firebase/storage.rules`)

## Gizlilik politikasını yayınlama (GitHub Pages)

1. Repoyu GitHub'a push edin
2. **Settings → Pages → Source:** GitHub Actions
3. Workflow: [`.github/workflows/pages.yml`](../.github/workflows/pages.yml)
4. Yayınlanan URL'yi mağaza formlarına yapıştırın

## Build komutları

```bash
# Android imzalama (ilk kez)
cd app && ./scripts/setup-android-signing.sh

# Release build
cd app && flutter build appbundle --release   # Google Play
cd app && ./scripts/build-ios-release.sh      # App Store (macOS)
```

## Paket bilgileri

| Platform | Kimlik |
|----------|--------|
| Android | `com.tngrstudio.babysleepsounds` |
| iOS | `com.tngrstudio.babysleepsounds` |
| Sürüm | 2.0.0 (build 1) |
| Görünen ad | Bebek Uyku Sesleri |
