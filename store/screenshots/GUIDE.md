# Ekran Görüntüsü Rehberi

Mağaza listelerinde en az **4, en iyi sonuç için 6–8** ekran görüntüsü kullanın. Tüm görüntülerde karanlık tema açık olsun; telefon saati ve bildirim çubuğu mümkünse temiz/gizli olsun.

## Önerilen ekranlar (sırayla)

| # | Ekran | Mesaj (overlay metni önerisi) |
|---|--------|-------------------------------|
| 1 | Ana sayfa — 4 kategori grid | "4 kategori, 50+ sakinleştirici ses" |
| 2 | Beyaz Gürültü listesi | "Fan, yağmur, okyanus ve daha fazlası" |
| 3 | Ninniler listesi | "Türk ve dünya ninneleri" |
| 4 | Oynatıcı — ses çalıyor | "Döngüsel çalma ve mini oynatıcı" |
| 5 | Uyku zamanlayıcısı sheet | "15–120 dk uyku zamanlayıcısı" |
| 6 | Favoriler | "Favorilerinizi kaydedin" |

Overlay metinleri isteğe bağlıdır; Figma/Canva ile PNG üzerine eklenebilir.

---

## Google Play boyutları

| Varlık | Boyut | Format | Zorunlu |
|--------|-------|--------|---------|
| Uygulama ikonu | 512 × 512 | PNG | Evet |
| Feature Graphic | 1024 × 500 | PNG veya JPEG | Evet |
| Telefon ekran görüntüsü | min 320px, max 3840px (uzun kenar) | PNG veya JPEG | Evet (min 2) |
| 7" tablet | 1200 × 1920 | PNG/JPEG | Hayır |
| 10" tablet | 1600 × 2560 | PNG/JPEG | Hayır |

**Pratik telefon boyutu:** 1080 × 1920 veya 1440 × 2560 (9:16)

### Feature Graphic metin önerisi

```
Bebek Uyku Sesleri
Ninni · Beyaz Gürültü · Zamanlayıcı
```

Arka plan: `#2D1B69` (uygulama teması). Hazır dosya: `store/play-store/graphics/feature-graphic-1024x500.png`

Marka: **Tngr**

---

## App Store boyutları

| Cihaz | Boyut (px) | Zorunlu |
|-------|------------|---------|
| iPhone 6.7" | 1290 × 2796 | Evet (güncel iPhone) |
| iPhone 6.5" | 1284 × 2778 | Alternatif |
| iPhone 5.5" | 1242 × 2208 | Eski cihaz (isteğe bağlı) |
| iPad Pro 12.9" | 2048 × 2732 | iPad destekliyorsa |

**App Store Preview Video (isteğe bağlı):** 15–30 sn, aynı ekran akışı, ses kapalı veya düşük.

---

## Nasıl alınır?

### Android emülatör / cihaz

```bash
cd app
flutter run
# Cihazda ekran görüntüsü al veya:
adb exec-out screencap -p > ../store/screenshots/android/01-home.png
```

### iOS Simulator

```bash
cd app
flutter run
# Simulator: Cmd+S veya
xcrun simctl io booted screenshot ../store/screenshots/ios/01-home.png
```

### Flutter integration test (ileri seviye)

Mağaza görüntüleri için `integration_test/` ile otomatik screenshot alınabilir — şimdilik manuel yeterli.

---

## Klasör yapısı

```
store/screenshots/
├── android/
│   ├── 01-home.png
│   ├── 02-white-noise.png
│   └── ...
├── ios/
│   ├── 01-home.png
│   └── ...
└── feature-graphic-1024x500.png
```

Bu klasörler `.gitkeep` ile oluşturuldu; PNG'leri buraya koyun.

---

## Kalite kontrol

- [ ] Metin okunaklı (karanlık arka planda açık renk)
- [ ] Kişisel bilgi / bildirim gizlendi
- [ ] Tüm ekranlar aynı cihaz çözünürlüğünde
- [ ] Oynatıcı ekranında ses "çalıyor" durumunda
- [ ] Türkçe mağaza için Türkçe overlay metinleri
