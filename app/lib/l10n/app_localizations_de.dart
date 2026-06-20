// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Baby Schlafgeräusche';

  @override
  String get favorites => 'Favoriten';

  @override
  String get refreshCatalog => 'Katalog aktualisieren';

  @override
  String get language => 'Sprache';

  @override
  String get systemLanguage => 'Systemsprache';

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
    return '$count Sounds';
  }

  @override
  String get categoryWhiteNoise => 'Weißes Rauschen';

  @override
  String get categoryLullaby => 'Schlaflieder';

  @override
  String get categoryRelaxing => 'Entspannend';

  @override
  String get categoryMusic => 'Musik';

  @override
  String get homeHeaderSubtitle => 'Ruhiger Schlaf, süße Träume';

  @override
  String get developedBy => 'Tngr';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get favoritesEmptyTitle => 'Noch keine Favoriten';

  @override
  String get favoritesEmptyBody =>
      'Tippe auf das Herz bei einem Sound, um ihn hier zu speichern.';

  @override
  String get emptyCategory => 'Keine Sounds in dieser Kategorie';

  @override
  String get downloadOnFirstPlay =>
      'Wird beim ersten Abspielen heruntergeladen';

  @override
  String downloadFailed(String error) {
    return 'Sound konnte nicht heruntergeladen werden: $error';
  }

  @override
  String get sleepTimer => 'Schlaf-Timer';

  @override
  String get sleepTimerHint =>
      'Der Sound wiederholt sich bis zum Ende der gewählten Zeit.';

  @override
  String minutesOption(int count) {
    return '$count Min.';
  }

  @override
  String get unlimited => 'Unbegrenzt';

  @override
  String get cancelTimer => 'Timer abbrechen';

  @override
  String timerRemaining(String time) {
    return 'Verbleibend: $time';
  }

  @override
  String playingStatus(String time) {
    return 'Wiedergabe · $time';
  }

  @override
  String get pausedStatus => 'Pausiert';
}
