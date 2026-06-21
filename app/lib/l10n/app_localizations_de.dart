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
  String get playlist => 'Wiedergabeliste';

  @override
  String get playAll => 'Alle abspielen';

  @override
  String get playlistHint =>
      'Favoriten werden der Reihe nach abgespielt. Mit vor und zurück wechseln.';

  @override
  String get nextTrack => 'Nächster Titel';

  @override
  String get previousTrack => 'Vorheriger Titel';

  @override
  String get refreshCatalog => 'Katalog aktualisieren';

  @override
  String get refreshCatalogInProgress => 'Katalog wird aktualisiert…';

  @override
  String refreshCatalogUpdated(int count) {
    return 'Katalog aktualisiert · $count Sounds';
  }

  @override
  String get refreshCatalogUpToDate => 'Katalog ist bereits aktuell.';

  @override
  String refreshCatalogUsedCache(int count) {
    return 'Server nicht erreichbar. Gespeicherter Katalog ($count Sounds).';
  }

  @override
  String refreshCatalogOffline(int count) {
    return 'Offline. Lokaler Katalog ($count Sounds).';
  }

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
  String get developedBy => 'Tngr Studio';

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

  @override
  String get supportMenu => 'Entwicklung unterstützen';

  @override
  String get rateApp => 'App bewerten';

  @override
  String get supportLink => 'Entwicklung unterstützen';

  @override
  String get supportTitle => 'Freiwillige Unterstützung';

  @override
  String get supportBody =>
      'Diese App ist kostenlos und werbefrei. Wenn sie dir gefällt, kannst du die Entwicklung freiwillig unterstützen. Keine Funktionen sind gesperrt.';

  @override
  String get supportCoffeeTitle => 'Ein Kaffee';

  @override
  String get supportCoffeeSubtitle => 'Ein kleines Dankeschön';

  @override
  String get supportMealTitle => 'Eine Mahlzeit';

  @override
  String get supportMealSubtitle => 'Entwicklung unterstützen';

  @override
  String get supportGenerousTitle => 'Großzügige Unterstützung';

  @override
  String get supportGenerousSubtitle => 'Extra Dank';

  @override
  String get supportThankYou => 'Danke für deine Unterstützung!';

  @override
  String get supportUnavailable =>
      'Unterstützungsoptionen sind derzeit nicht verfügbar. Bitte später erneut versuchen.';

  @override
  String get supportProductsPending =>
      'Käufe sind verfügbar, sobald die Produkte in Play Console aktiv sind.';

  @override
  String get supportPricePending => 'Bald';

  @override
  String get supportPurchasing => 'Wird verarbeitet…';

  @override
  String get supportPurchaseFailed =>
      'Kauf konnte nicht abgeschlossen werden. Bitte erneut versuchen.';

  @override
  String get homeSupportCta => 'Spendier einen Kaffee';

  @override
  String get homeSupportHint => 'Freiwillige Unterstützung · Werbefrei';
}
