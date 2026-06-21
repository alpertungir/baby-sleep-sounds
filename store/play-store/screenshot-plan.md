# Ekran görüntüsü sırası ve overlay metinleri (Play Console)

Telefon: **1080 × 1920** veya **1440 × 2560** (9:16). Karanlık tema, bildirim çubuğu temiz.

Dosyalar: `store/screenshots/android/01-home.png` … `06-favorites.png`

---

## Önerilen 6 ekran

| Dosya | Ekran | Overlay TR | Overlay EN |
|-------|--------|------------|------------|
| `01-home.png` | Ana sayfa — 4 kategori | 4 kategori, 50+ ses | 4 categories, 50+ sounds |
| `02-white-noise.png` | Beyaz gürültü listesi | Fan, yağmur, okyanus… | Fan, rain, ocean… |
| `03-lullaby.png` | Ninniler listesi | Türk ve dünya ninnileri | Turkish & world lullabies |
| `04-player.png` | Ses çalıyor + mini player | Kilit ekranından kontrol | Lock screen controls |
| `05-timer.png` | Uyku zamanlayıcısı | 15–120 dk zamanlayıcı | 15–120 min sleep timer |
| `06-favorites.png` | Favoriler + çalma listesi | Favoriler ve çalma listesi | Favorites & playlist |

**ASO overlay anahtar kelimeleri (Canva):** bebek uyku sesi · ninni · beyaz gürültü · reklamsız · 50+ ses · çevrimdışı

---

## Hızlı alma (USB)

```bash
cd app
export GRADLE_USER_HOME=$HOME/.gradle
flutter run -d <CIHAZ_ID>

# Her ekranda:
adb exec-out screencap -p > ../store/screenshots/android/01-home.png
```

Overlay metinleri isteğe bağlı — Canva/Figma ile PNG üzerine eklenebilir.

---

## Play Console yükleme

1. **Store listing → Graphics**
   - App icon: `store/play-store/graphics/icon-512.png`
   - Feature graphic: `store/play-store/graphics/feature-graphic-1024x500.png`
2. **Phone screenshots:** `store/screenshots/android/*.png` (min 2, öneri 6)
