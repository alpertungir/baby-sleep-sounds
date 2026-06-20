# Mağaza Yayın Kontrol Listesi

Yayınlamadan önce tüm maddeleri tamamlayın.

## Genel

- [ ] `store/play-store/metadata.yaml` ve `store/app-store/metadata.yaml` içindeki e-posta ve URL'ler güncellendi
- [ ] Gizlilik politikası GitHub Pages'te yayında (aşağıya bakın)
- [ ] Uygulama ikonu ve splash test edildi (gerçek cihazda)
- [ ] Release build alındı ve ses çalma / zamanlayıcı / favoriler test edildi

## Gizlilik politikası (GitHub Pages)

- [ ] Repo GitHub'a push edildi
- [ ] **Settings → Pages → Source:** GitHub Actions
- [ ] `main` branch'e push sonrası workflow yeşil
- [ ] URL açılıyor: `https://alpertungir.github.io/baby-sleep-sounds/privacy-policy.html`
- [ ] Mağaza formlarına bu URL girildi

Detay: [`docs/github-pages.md`](docs/github-pages.md)

---

## Google Play

- [ ] Google Play Console hesabı ($25 tek seferlik)
- [ ] Uygulama oluşturuldu: `com.alfaapps.BabySleepSounds`
- [ ] **Store listing** — TR (+ isteğe bağlı EN) metinler yapıştırıldı
- [ ] **Kısa açıklama** (80 karakter): `Bebeğiniz için ninni, beyaz gürültü ve rahatlatıcı sesler.`
- [ ] **Kategori:** Parenting (Ebeveynlik)
- [ ] **Grafikler:** 512 ikon, 1024×500 feature graphic, min 2 screenshot
- [ ] **Content rating** anketi tamamlandı
- [ ] **Data safety:** veri toplanmıyor olarak işaretlendi
- [ ] **Target audience:** ebeveynler / aile (reklam yoksa Children programı zorunlu değil)
- [ ] **Release signing** yapılandırıldı (aşağıya bakın)
- [ ] AAB yüklendi: `flutter build appbundle --release`

### Android imzalama

```bash
cd app
chmod +x scripts/setup-android-signing.sh
./scripts/setup-android-signing.sh
# android/key.properties içindeki şifreleri doldurun
flutter build appbundle --release
```

Detay: [`docs/android-signing.md`](docs/android-signing.md)

---

## App Store

- [ ] Apple Developer Program ($99/yıl)
- [ ] Bundle ID: `com.babysleep.babySleepSounds` (Developer Console + Xcode)
- [ ] **iOS imzalama** yapılandırıldı (aşağıya bakın)
- [ ] **App Information:** birincil kategori Health & Fitness veya Lifestyle
- [ ] **Pricing:** Free
- [ ] **Age Rating** anketi (4+)
- [ ] **App Privacy:** veri toplanmıyor
- [ ] **Screenshots:** 1290×2796 (iPhone 6.7") min 3 adet
- [ ] **Support URL** ve **Privacy Policy URL** girildi
- [ ] IPA yüklendi (Transporter veya Xcode Organizer)

### iOS imzalama (macOS gerekir)

```bash
cd app
chmod +x scripts/setup-ios-signing.sh scripts/build-ios-release.sh
./scripts/setup-ios-signing.sh
open ios/Runner.xcworkspace   # Team + signing doğrula
./scripts/build-ios-release.sh
```

Detay: [`docs/ios-signing.md`](docs/ios-signing.md)

---

## Yayın sonrası

- [ ] Mağaza linkleri README'ye eklendi
- [ ] İlk kullanıcı geri bildirimleri izleniyor
- [ ] Gerçek ninni/ses dosyaları placeholder'ların yerine kondu (isteğe bağlı güncelleme)
