// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Suoni per Dormire Bebè';

  @override
  String get favorites => 'Preferiti';

  @override
  String get refreshCatalog => 'Aggiorna catalogo';

  @override
  String get language => 'Lingua';

  @override
  String get systemLanguage => 'Lingua di sistema';

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
    return '$count suoni';
  }

  @override
  String get categoryWhiteNoise => 'Rumore bianco';

  @override
  String get categoryLullaby => 'Ninne';

  @override
  String get categoryRelaxing => 'Rilassante';

  @override
  String get categoryMusic => 'Musica';

  @override
  String get homeHeaderSubtitle => 'Sonno tranquillo, sogni dolci';

  @override
  String get developedBy => 'Alfa Apps';

  @override
  String versionLabel(String version) {
    return 'Versione $version';
  }

  @override
  String get favoritesEmptyTitle => 'Nessun preferito';

  @override
  String get favoritesEmptyBody =>
      'Tocca il cuore su un suono per aggiungerlo qui.';

  @override
  String get emptyCategory => 'Nessun suono in questa categoria';

  @override
  String get downloadOnFirstPlay => 'Si scarica al primo ascolto';

  @override
  String downloadFailed(String error) {
    return 'Impossibile scaricare il suono: $error';
  }

  @override
  String get sleepTimer => 'Timer del sonno';

  @override
  String get sleepTimerHint =>
      'Il suono si ripete fino alla fine del tempo selezionato.';

  @override
  String minutesOption(int count) {
    return '$count min';
  }

  @override
  String get unlimited => 'Illimitato';

  @override
  String get cancelTimer => 'Annulla timer';

  @override
  String timerRemaining(String time) {
    return 'Rimanente: $time';
  }

  @override
  String playingStatus(String time) {
    return 'In riproduzione · $time';
  }

  @override
  String get pausedStatus => 'In pausa';
}
