#!/usr/bin/env bash
# Android upload keystore ve key.properties kurulumu.
# Kullanım: ./scripts/setup-android-signing.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ANDROID_DIR="$ROOT/android"
KEYSTORE="$ANDROID_DIR/upload-keystore.jks"
PROPS="$ANDROID_DIR/key.properties"
EXAMPLE="$ANDROID_DIR/key.properties.example"

cd "$ROOT"

echo "==> Bebek Uyku Sesleri — Android imzalama kurulumu"
echo ""

if [[ -f "$KEYSTORE" ]]; then
  echo "Keystore zaten var: $KEYSTORE"
  read -r -p "Yeniden oluşturmak istiyor musunuz? (y/N) " answer
  if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Keystore oluşturma atlandı."
  else
    rm -f "$KEYSTORE"
  fi
fi

if [[ ! -f "$KEYSTORE" ]]; then
  echo ""
  echo "Upload keystore oluşturuluyor..."
  echo "Sorulan bilgileri not alın; Play Console'a da gerekebilir."
  echo ""
  keytool -genkey -pair -v \
    -keystore "$KEYSTORE" \
    -alias upload \
    -keyalg RSA \
    -keysize 2048 \
    -validity 10000
fi

if [[ ! -f "$PROPS" ]]; then
  cp "$EXAMPLE" "$PROPS"
  echo ""
  echo "key.properties oluşturuldu: $PROPS"
  echo "storePassword ve keyPassword değerlerini düzenleyin."
else
  echo "key.properties zaten var: $PROPS"
fi

echo ""
echo "Sonraki adımlar:"
echo "  1. $PROPS içindeki şifreleri doldurun"
echo "  2. cd $ROOT && flutter build appbundle --release"
echo "  3. Çıktı: build/app/outputs/bundle/release/app-release.aab"
echo ""
echo "Keystore yedeğini güvenli bir yerde saklayın. Kaybederseniz uygulama güncellenemez."
