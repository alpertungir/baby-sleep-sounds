// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Bebek Uyku Sesleri';

  @override
  String get favorites => 'Favoriler';

  @override
  String get refreshCatalog => 'Katalogu yenile';

  @override
  String get language => 'Dil';

  @override
  String get turkish => 'Türkçe';

  @override
  String get english => 'English';

  @override
  String soundCount(int count) {
    return '$count ses';
  }

  @override
  String get categoryWhiteNoise => 'Beyaz Gürültü';

  @override
  String get categoryTurkishLullaby => 'Türk Ninneleri';

  @override
  String get categoryLullaby => 'Ninni';

  @override
  String get categoryClassic => 'Klasik';

  @override
  String get categoryRelaxing => 'Rahatlatıcı';

  @override
  String get categoryBackground => 'Arka Plan';

  @override
  String get categoryNational => 'Dünya Ninneleri';

  @override
  String get favoritesEmptyTitle => 'Henüz favori yok';

  @override
  String get favoritesEmptyBody =>
      'Ses listesindeki kalbe dokunarak ekleyebilirsin.';

  @override
  String get emptyCategory => 'Bu kategoride ses yok';

  @override
  String get downloadOnFirstPlay => 'İlk dinlemede indirilir';

  @override
  String downloadFailed(String error) {
    return 'Ses indirilemedi: $error';
  }

  @override
  String get sleepTimer => 'Uyku Zamanlayıcısı';

  @override
  String minutesOption(int count) {
    return '$count dakika';
  }

  @override
  String get unlimited => 'Sınırsız';

  @override
  String get cancelTimer => 'Zamanlayıcıyı iptal et';

  @override
  String timerRemaining(String time) {
    return 'Kalan: $time';
  }

  @override
  String playingStatus(String time) {
    return 'Çalıyor · $time';
  }

  @override
  String get pausedStatus => 'Duraklatıldı';
}
