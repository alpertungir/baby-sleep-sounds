// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Sonidos para Dormir Bebé';

  @override
  String get favorites => 'Favoritos';

  @override
  String get refreshCatalog => 'Actualizar catálogo';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Idioma del sistema';

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
    return '$count sonidos';
  }

  @override
  String get categoryWhiteNoise => 'Ruido blanco';

  @override
  String get categoryLullaby => 'Nanas';

  @override
  String get categoryRelaxing => 'Relajante';

  @override
  String get categoryMusic => 'Música';

  @override
  String get homeHeaderSubtitle => 'Sueños tranquilos y dulces';

  @override
  String get developedBy => 'Tngr';

  @override
  String versionLabel(String version) {
    return 'Versión $version';
  }

  @override
  String get favoritesEmptyTitle => 'Aún no hay favoritos';

  @override
  String get favoritesEmptyBody =>
      'Toca el corazón en un sonido para añadirlo aquí.';

  @override
  String get emptyCategory => 'No hay sonidos en esta categoría';

  @override
  String get downloadOnFirstPlay => 'Se descarga al reproducir por primera vez';

  @override
  String downloadFailed(String error) {
    return 'No se pudo descargar el sonido: $error';
  }

  @override
  String get sleepTimer => 'Temporizador de sueño';

  @override
  String get sleepTimerHint =>
      'El sonido se repite hasta que termine el tiempo seleccionado.';

  @override
  String minutesOption(int count) {
    return '$count min';
  }

  @override
  String get unlimited => 'Ilimitado';

  @override
  String get cancelTimer => 'Cancelar temporizador';

  @override
  String timerRemaining(String time) {
    return 'Restante: $time';
  }

  @override
  String playingStatus(String time) {
    return 'Reproduciendo · $time';
  }

  @override
  String get pausedStatus => 'En pausa';
}
