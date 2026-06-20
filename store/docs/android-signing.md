# Android Release İmzalama

Play Store'a yüklemek için release AAB'nin upload keystore ile imzalanması gerekir.

## Hızlı kurulum

```bash
cd app
chmod +x scripts/setup-android-signing.sh
./scripts/setup-android-signing.sh
```

Script:
1. `android/upload-keystore.jks` oluşturur (yoksa)
2. `android/key.properties.example` → `android/key.properties` kopyalar

Ardından `android/key.properties` içindeki şifreleri doldurun:

```properties
storePassword=GERÇEK_STORE_ŞİFRESİ
keyPassword=GERÇEK_KEY_ŞİFRESİ
keyAlias=upload
storeFile=../upload-keystore.jks
```

## Release build

```bash
cd app
flutter build appbundle --release
```

Çıktı:

```
app/build/app/outputs/bundle/release/app-release.aab
```

Bu dosyayı [Google Play Console](https://play.google.com/console) → Production → Create new release bölümüne yükleyin.

## Manuel keystore (alternatif)

```bash
cd app/android
keytool -genkey -pair -v \
  -keystore upload-keystore.jks \
  -alias upload \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000

cp key.properties.example key.properties
# key.properties şifrelerini düzenleyin
```

## Güvenlik

| Dosya | Git'e eklenir mi? |
|-------|-------------------|
| `key.properties.example` | Evet (şablon) |
| `key.properties` | **Hayır** |
| `upload-keystore.jks` | **Hayır** |

Keystore yedeğini password manager veya güvenli depoda saklayın. Kaybedilirse aynı paket adıyla güncelleme yapılamaz.

## key.properties yoksa

`build.gradle.kts` uyarı verir ve release build debug key ile imzalanır. Mağazaya yüklenemez; yalnızca yerel test içindir.

## Play App Signing

Google Play App Signing önerilir. İlk yüklemeden sonra Google upload key'inizi yönetir; keystore yedeğinizi yine de saklayın.

Detay: [Flutter — Android deployment](https://docs.flutter.dev/deployment/android)
