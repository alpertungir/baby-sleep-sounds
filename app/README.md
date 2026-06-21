# Bebek Uyku Sesleri

Bebek uyutmak için sade, modern bir Flutter uygulaması.

## Özellikler

- **7 kategori:** Beyaz Gürültü, Türk Ninneleri, Ninni, Klasik, Rahatlatıcı, Arka Plan, Dünya Ninneleri
- **71 ses** — döngüsel çalma, ses seviyesi, uyku zamanlayıcısı, favoriler
- Karanlık Material 3 arayüz
- Firebase, reklam ve karmaşık mimari **yok**

## Hızlı başlangıç

```bash
cd app
flutter pub get
flutter run
```

## Mağaza yayını

Hazır listing metinleri, gizlilik politikası ve ekran görüntüsü rehberi:

→ [`../store/README.md`](../store/README.md)

| Adım | Rehber |
|------|--------|
| Android imzalama | [`../store/docs/android-signing.md`](../store/docs/android-signing.md) |
| iOS imzalama | [`../store/docs/ios-signing.md`](../store/docs/ios-signing.md) |
| GitHub Pages (gizlilik URL) | [`../store/docs/github-pages.md`](../store/docs/github-pages.md) |
| Kontrol listesi | [`../store/CHECKLIST.md`](../store/CHECKLIST.md) |

```bash
# İlk kez Android imzalama
cd app
chmod +x scripts/setup-android-signing.sh
./scripts/setup-android-signing.sh
flutter build appbundle --release
```

İkon ve splash güncellemek için:

```bash
cd app
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

Android release:

```bash
flutter build appbundle --release
```

iOS release (macOS + Xcode):

```bash
./scripts/setup-ios-signing.sh
open ios/Runner.xcworkspace   # Team seçimini doğrula
./scripts/build-ios-release.sh
```

## Ses dosyaları

Örnek sesler `scripts/generate_sounds.py` ile üretilir. Gerçek ninni/müzik dosyalarını eklemek için:

1. WAV veya MP3 dosyasını ilgili `assets/sounds/<kategori>/` klasörüne koy
2. `lib/data/sounds/<kategori>_sounds.dart` dosyasına `SoundItem` ekle
3. Gerekirse `scripts/generate_sounds.py` manifestine slug ekle

Türk ninnileri için ayrı klasör: `assets/sounds/turkish_lullaby/`

## Proje yapısı

```
app/
├── lib/
│   ├── data/
│   │   ├── categories.dart
│   │   ├── sound_catalog.dart
│   │   └── sounds/          # Kategori bazlı ses listeleri
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── services/
│   ├── theme/
│   └── widgets/
├── assets/
│   ├── icons/               # Uygulama ikonu
│   ├── images/
│   └── sounds/
└── scripts/
    └── generate_sounds.py
```

## Teknoloji

- Flutter 3.44+ / Dart 3.12+
- `just_audio`, `provider`, `shared_preferences`
