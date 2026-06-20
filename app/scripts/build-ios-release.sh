#!/usr/bin/env bash
# App Store IPA derler (macOS, Xcode, Apple Developer hesabı gerekir).
# Kullanım: ./scripts/build-ios-release.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EXPORT_PLIST="$ROOT/ios/export/ExportOptions.appstore.plist"
SIGNING_XCCONFIG="$ROOT/ios/Flutter/Signing.xcconfig"

cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Hata: iOS build yalnızca macOS üzerinde çalışır."
  exit 1
fi

if [[ ! -f "$SIGNING_XCCONFIG" ]]; then
  echo "Hata: ios/Flutter/Signing.xcconfig bulunamadı."
  echo "Önce çalıştırın: ./scripts/setup-ios-signing.sh"
  exit 1
fi

if [[ ! -f "$EXPORT_PLIST" ]]; then
  echo "Hata: $EXPORT_PLIST bulunamadı."
  echo "Önce çalıştırın: ./scripts/setup-ios-signing.sh"
  exit 1
fi

echo "==> Flutter IPA (App Store) derleniyor..."
flutter pub get
flutter build ipa --release --export-options-plist="$EXPORT_PLIST"

echo ""
echo "Tamamlandı."
echo "IPA: $ROOT/build/ios/ipa/"
ls -la "$ROOT/build/ios/ipa/" 2>/dev/null || true
echo ""
echo "Yükleme seçenekleri:"
echo "  • Xcode → Window → Organizer → Distribute App"
echo "  • Transporter uygulaması (Mac App Store)"
echo "  • xcrun altool --upload-app (CLI, aşağıdaki rehbere bakın)"
