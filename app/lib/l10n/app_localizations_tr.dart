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
  String get systemLanguage => 'Telefon dili';

  @override
  String get turkish => 'Türkçe';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Français';

  @override
  String get german => 'Deutsch';

  @override
  String get italian => 'Italiano';

  @override
  String get russian => 'Русский';

  @override
  String get arabic => 'العربية';

  @override
  String soundCount(int count) {
    return '$count ses';
  }

  @override
  String get categoryWhiteNoise => 'Beyaz Gürültü';

  @override
  String get categoryLullaby => 'Ninniler';

  @override
  String get categoryRelaxing => 'Rahatlatıcı';

  @override
  String get categoryMusic => 'Müzik';

  @override
  String get homeHeaderSubtitle => 'Huzurlu uykular için';

  @override
  String get developedBy => 'Tngr Studio';

  @override
  String versionLabel(String version) {
    return 'Sürüm $version';
  }

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
  String get sleepTimerHint => 'Seçilen süre dolana kadar ses tekrar çalar.';

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

  @override
  String get supportMenu => 'Gönüllü destek';

  @override
  String get supportLink => 'Geliştirmeyi destekle';

  @override
  String get supportTitle => 'Gönüllü destek';

  @override
  String get supportBody =>
      'Bu uygulama reklamsız ve tamamen ücretsiz. Beğendiysen geliştirmeyi gönüllü olarak destekleyebilirsin. Hiçbir özellik kilitli değildir.';

  @override
  String get supportCoffeeTitle => 'Bir kahve';

  @override
  String get supportCoffeeSubtitle => 'Küçük bir teşekkür';

  @override
  String get supportMealTitle => 'Bir öğün';

  @override
  String get supportMealSubtitle => 'Geliştirmeyi destekle';

  @override
  String get supportGenerousTitle => 'Cömert destek';

  @override
  String get supportGenerousSubtitle => 'Ekstra teşekkürler';

  @override
  String get supportThankYou => 'Desteğin için teşekkürler!';

  @override
  String get supportUnavailable =>
      'Destek seçenekleri şu an kullanılamıyor. Daha sonra tekrar dene.';

  @override
  String get supportProductsPending =>
      'Satın alma, Play Console\'da ürünler etkinleştirildikten ve uygulama test kanalına yüklendikten sonra açılır.';

  @override
  String get supportPricePending => 'Yakında';

  @override
  String get supportPurchasing => 'İşleniyor…';

  @override
  String get supportPurchaseFailed =>
      'Satın alma tamamlanamadı. Lütfen tekrar dene.';

  @override
  String get homeSupportCta => 'Bir kahve ısmarla';

  @override
  String get homeSupportHint => 'Gönüllü destek · Reklamsız uygulama';
}
