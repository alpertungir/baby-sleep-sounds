#!/usr/bin/env bash
# iOS imzalama dosyalarını oluşturur (Team ID gerekir).
# Kullanım: ./scripts/setup-ios-signing.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FLUTTER_DIR="$ROOT/ios/Flutter"
EXPORT_DIR="$ROOT/ios/export"

cd "$ROOT"

echo "==> Bebek Uyku Sesleri — iOS imzalama kurulumu"
echo ""
echo "Team ID'nizi bulmak için:"
echo "  https://developer.apple.com/account → Membership details"
echo ""

if [[ -f "$FLUTTER_DIR/Signing.xcconfig" ]]; then
  echo "Mevcut: ios/Flutter/Signing.xcconfig"
  read -r -p "Üzerine yazılsın mı? (y/N) " overwrite
  if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
    echo "Signing.xcconfig atlandı."
  else
    rm -f "$FLUTTER_DIR/Signing.xcconfig"
  fi
fi

if [[ ! -f "$FLUTTER_DIR/Signing.xcconfig" ]]; then
  read -r -p "Apple Team ID (10 karakter): " TEAM_ID
  if [[ ${#TEAM_ID} -lt 10 ]]; then
    echo "Hata: Geçerli bir Team ID girin."
    exit 1
  fi

  cp "$FLUTTER_DIR/Signing.xcconfig.example" "$FLUTTER_DIR/Signing.xcconfig"
  sed -i "s/YOUR_TEAM_ID/$TEAM_ID/g" "$FLUTTER_DIR/Signing.xcconfig"
  echo "Oluşturuldu: ios/Flutter/Signing.xcconfig"
else
  TEAM_ID="$(grep DEVELOPMENT_TEAM "$FLUTTER_DIR/Signing.xcconfig" | cut -d= -f2)"
fi

mkdir -p "$EXPORT_DIR"

for kind in appstore adhoc; do
  target="$EXPORT_DIR/ExportOptions.${kind}.plist"
  example="$EXPORT_DIR/ExportOptions.${kind}.plist.example"
  if [[ -f "$target" ]]; then
    echo "Mevcut: $target (atlandı)"
  else
    cp "$example" "$target"
    sed -i "s/YOUR_TEAM_ID/$TEAM_ID/g" "$target"
    echo "Oluşturuldu: $target"
  fi
done

echo ""
echo "Sonraki adımlar (macOS + Xcode gerekir):"
echo ""
echo "  1. Apple Developer'da App ID oluşturun:"
echo "     Bundle ID: com.babysleep.babySleepSounds"
echo ""
echo "  2. Xcode'da bir kez açıp imzalamayı doğrulayın:"
echo "     open ios/Runner.xcworkspace"
echo "     Runner → Signing & Capabilities → Team seçin"
echo "     Automatically manage signing: açık"
echo ""
echo "  3. App Store IPA derleyin:"
echo "     ./scripts/build-ios-release.sh"
echo ""
echo "  4. App Store Connect'te uygulama kaydı oluşturun ve IPA yükleyin"
echo ""
echo "Detay: store/docs/ios-signing.md"
