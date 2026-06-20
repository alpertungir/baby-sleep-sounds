# iOS Release İmzalama ve App Store Yükleme

App Store'a yüklemek için Apple Developer hesabı, macOS ve Xcode gerekir.

## Gereksinimler

| Gereksinim | Not |
|------------|-----|
| Apple Developer Program | $99/yıl |
| macOS + Xcode | Son stable sürüm |
| Bundle ID | `com.babysleep.babySleepSounds` |
| Team ID | 10 karakterlik Apple Team ID |

---

## Hızlı kurulum

```bash
cd app
chmod +x scripts/setup-ios-signing.sh scripts/build-ios-release.sh
./scripts/setup-ios-signing.sh
```

Script şunları oluşturur:

| Dosya | Amaç |
|-------|------|
| `ios/Flutter/Signing.xcconfig` | Xcode Team ID |
| `ios/export/ExportOptions.appstore.plist` | App Store IPA export |
| `ios/export/ExportOptions.adhoc.plist` | TestFlight / cihaz testi |

Bu dosyalar **Git'e eklenmez** (Team ID içerir).

---

## Apple Developer Console

1. [developer.apple.com](https://developer.apple.com/account) → **Certificates, Identifiers & Profiles**
2. **Identifiers → +** → App IDs → App
3. Bundle ID: `com.babysleep.babySleepSounds`
4. Description: `Bebek Uyku Sesleri`
5. Capabilities: özel capability gerekmez (arka plan sesi Info.plist'te tanımlı)

---

## Xcode imzalama (ilk kez)

```bash
cd app
open ios/Runner.xcworkspace
```

1. Sol panel → **Runner** projesi
2. **Signing & Capabilities**
3. **Team:** Apple Developer hesabınız
4. **Bundle Identifier:** `com.babysleep.babySleepSounds`
5. **Automatically manage signing:** işaretli
6. Release scheme ile gerçek cihazda bir kez çalıştırın (opsiyonel test)

---

## IPA derleme

```bash
cd app
./scripts/build-ios-release.sh
```

Alternatif (doğrudan Flutter):

```bash
flutter build ipa --release \
  --export-options-plist=ios/export/ExportOptions.appstore.plist
```

Çıktı:

```
app/build/ios/ipa/baby_sleep_sounds.ipa
```

---

## ExportOptions.plist alanları

**App Store (`ExportOptions.appstore.plist`):**

```xml
<key>method</key>
<string>app-store-connect</string>
<key>teamID</key>
<string>SİZİN_TEAM_ID</string>
<key>signingStyle</key>
<string>automatic</string>
<key>destination</key>
<string>upload</string>
```

**Ad Hoc / Test (`ExportOptions.adhoc.plist`):**

```xml
<key>method</key>
<string>release-testing</string>
```

Şablonlar: `app/ios/export/*.plist.example`

---

## App Store Connect'e yükleme

### Yöntem 1 — Transporter (önerilen)

1. Mac App Store'dan [Transporter](https://apps.apple.com/app/transporter/id1450874784) indirin
2. IPA dosyasını sürükleyip bırakın
3. Apple ID ile giriş yapın ve yükleyin

### Yöntem 2 — Xcode Organizer

1. Xcode → **Window → Organizer**
2. Archives sekmesi → son archive → **Distribute App**
3. **App Store Connect** → Upload

### Yöntem 3 — Komut satırı

App-specific password gerekir ([appleid.apple.com](https://appleid.apple.com) → App-Specific Passwords):

```bash
xcrun altool --upload-app \
  -f app/build/ios/ipa/baby_sleep_sounds.ipa \
  -t ios \
  -u "alperttungir@gmail.com" \
  -p "app-specific-password"
```

---

## App Store Connect kaydı

1. [appstoreconnect.apple.com](https://appstoreconnect.apple.com) → **My Apps → +**
2. Platform: iOS
3. Name: **Bebek Uyku Sesleri**
4. Bundle ID: `com.babysleep.babySleepSounds`
5. SKU: `baby-sleep-sounds-001`
6. Listing metinleri: [`../app-store/listing-tr.md`](../app-store/listing-tr.md)
7. Privacy Policy URL: GitHub Pages linkiniz
8. IPA yüklendikten sonra **TestFlight** ile test, ardından **Submit for Review**

---

## Arka planda ses çalma

`Info.plist` içinde `UIBackgroundModes → audio` tanımlıdır. Ekran kilitlendiğinde sesin devam etmesi için gereklidir. App Review'da ek açıklama gerekmez.

---

## Sorun giderme

| Hata | Çözüm |
|------|--------|
| No signing certificate | Xcode → Settings → Accounts → Download Manual Profiles |
| Bundle ID mismatch | Developer Console ve Xcode'daki ID aynı olmalı |
| Team ID bulunamıyor | `./scripts/setup-ios-signing.sh` tekrar çalıştırın |
| `flutter build ipa` Linux'ta | iOS build yalnızca macOS'ta çalışır |
| Invalid Provisioning Profile | Xcode'da Clean Build Folder, signing'i yeniden seçin |

---

## Güvenlik

| Dosya | Git'e eklenir mi? |
|-------|-------------------|
| `Signing.xcconfig.example` | Evet |
| `ExportOptions.*.plist.example` | Evet |
| `Signing.xcconfig` | **Hayır** |
| `ExportOptions.*.plist` (Team ID'li) | **Hayır** |

---

Detay: [Flutter iOS deployment](https://docs.flutter.dev/deployment/ios)
