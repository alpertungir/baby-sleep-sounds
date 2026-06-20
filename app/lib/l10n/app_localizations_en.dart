// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Baby Sleep Sounds';

  @override
  String get favorites => 'Favorites';

  @override
  String get refreshCatalog => 'Refresh catalog';

  @override
  String get language => 'Language';

  @override
  String get systemLanguage => 'System language';

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
    return '$count sounds';
  }

  @override
  String get categoryWhiteNoise => 'White Noise';

  @override
  String get categoryLullaby => 'Lullabies';

  @override
  String get categoryRelaxing => 'Relaxing';

  @override
  String get categoryMusic => 'Music';

  @override
  String get homeHeaderSubtitle => 'Peaceful sleep, sweet dreams';

  @override
  String get developedBy => 'Tngr';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get favoritesEmptyTitle => 'No favorites yet';

  @override
  String get favoritesEmptyBody => 'Tap the heart on a sound to add it here.';

  @override
  String get emptyCategory => 'No sounds in this category';

  @override
  String get downloadOnFirstPlay => 'Downloads on first play';

  @override
  String downloadFailed(String error) {
    return 'Could not download sound: $error';
  }

  @override
  String get sleepTimer => 'Sleep Timer';

  @override
  String get sleepTimerHint => 'Sound loops until the selected time ends.';

  @override
  String minutesOption(int count) {
    return '$count min';
  }

  @override
  String get unlimited => 'Unlimited';

  @override
  String get cancelTimer => 'Cancel timer';

  @override
  String timerRemaining(String time) {
    return 'Remaining: $time';
  }

  @override
  String playingStatus(String time) {
    return 'Playing · $time';
  }

  @override
  String get pausedStatus => 'Paused';
}
