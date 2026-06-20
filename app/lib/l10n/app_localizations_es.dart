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
  String get developedBy => 'Tngr Studio';

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

  @override
  String get supportMenu => 'Apoyar el desarrollo';

  @override
  String get supportLink => 'Apoyar el desarrollo';

  @override
  String get supportTitle => 'Apoyo voluntario';

  @override
  String get supportBody =>
      'Esta app es gratuita y sin anuncios. Si te gusta, puedes apoyar el desarrollo de forma voluntaria. Ninguna función está bloqueada.';

  @override
  String get supportCoffeeTitle => 'Un café';

  @override
  String get supportCoffeeSubtitle => 'Un pequeño agradecimiento';

  @override
  String get supportMealTitle => 'Una comida';

  @override
  String get supportMealSubtitle => 'Apoya el desarrollo';

  @override
  String get supportGenerousTitle => 'Apoyo generoso';

  @override
  String get supportGenerousSubtitle => 'Un extra de gratitud';

  @override
  String get supportThankYou => '¡Gracias por tu apoyo!';

  @override
  String get supportUnavailable =>
      'Las opciones de apoyo no están disponibles ahora. Inténtalo más tarde.';

  @override
  String get supportProductsPending =>
      'Las compras estarán disponibles cuando los productos estén activos en Play Console.';

  @override
  String get supportPricePending => 'Pronto';

  @override
  String get supportPurchasing => 'Procesando…';

  @override
  String get supportPurchaseFailed =>
      'No se pudo completar la compra. Inténtalo de nuevo.';

  @override
  String get homeSupportCta => 'Invítame un café';

  @override
  String get homeSupportHint => 'Apoyo voluntario · App sin anuncios';
}
