// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sons pour Dormir Bébé';

  @override
  String get favorites => 'Favoris';

  @override
  String get refreshCatalog => 'Actualiser le catalogue';

  @override
  String get language => 'Langue';

  @override
  String get systemLanguage => 'Langue du système';

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
    return '$count sons';
  }

  @override
  String get categoryWhiteNoise => 'Bruit blanc';

  @override
  String get categoryLullaby => 'Berceuses';

  @override
  String get categoryRelaxing => 'Relaxant';

  @override
  String get categoryMusic => 'Musique';

  @override
  String get homeHeaderSubtitle => 'Dodo paisible, doux rêves';

  @override
  String get developedBy => 'Alfa Apps';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get favoritesEmptyTitle => 'Pas encore de favoris';

  @override
  String get favoritesEmptyBody =>
      'Appuyez sur le cœur d\'un son pour l\'ajouter ici.';

  @override
  String get emptyCategory => 'Aucun son dans cette catégorie';

  @override
  String get downloadOnFirstPlay => 'Téléchargé à la première lecture';

  @override
  String downloadFailed(String error) {
    return 'Impossible de télécharger le son : $error';
  }

  @override
  String get sleepTimer => 'Minuteur de sommeil';

  @override
  String get sleepTimerHint =>
      'Le son se répète jusqu\'à la fin du temps choisi.';

  @override
  String minutesOption(int count) {
    return '$count min';
  }

  @override
  String get unlimited => 'Illimité';

  @override
  String get cancelTimer => 'Annuler le minuteur';

  @override
  String timerRemaining(String time) {
    return 'Restant : $time';
  }

  @override
  String playingStatus(String time) {
    return 'Lecture · $time';
  }

  @override
  String get pausedStatus => 'En pause';
}
