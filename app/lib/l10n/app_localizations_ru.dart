// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Звуки для сна малыша';

  @override
  String get favorites => 'Избранное';

  @override
  String get refreshCatalog => 'Обновить каталог';

  @override
  String get language => 'Язык';

  @override
  String get systemLanguage => 'Язык системы';

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
    return '$count звуков';
  }

  @override
  String get categoryWhiteNoise => 'Белый шум';

  @override
  String get categoryLullaby => 'Колыбельные';

  @override
  String get categoryRelaxing => 'Расслабляющие';

  @override
  String get categoryMusic => 'Музыка';

  @override
  String get homeHeaderSubtitle => 'Спокойный сон, сладкие сны';

  @override
  String get developedBy => 'Alfa Apps';

  @override
  String versionLabel(String version) {
    return 'Версия $version';
  }

  @override
  String get favoritesEmptyTitle => 'Пока нет избранного';

  @override
  String get favoritesEmptyBody =>
      'Нажмите на сердечко у звука, чтобы добавить его сюда.';

  @override
  String get emptyCategory => 'В этой категории нет звуков';

  @override
  String get downloadOnFirstPlay => 'Загружается при первом воспроизведении';

  @override
  String downloadFailed(String error) {
    return 'Не удалось загрузить звук: $error';
  }

  @override
  String get sleepTimer => 'Таймер сна';

  @override
  String get sleepTimerHint =>
      'Звук повторяется до окончания выбранного времени.';

  @override
  String minutesOption(int count) {
    return '$count мин';
  }

  @override
  String get unlimited => 'Без ограничений';

  @override
  String get cancelTimer => 'Отменить таймер';

  @override
  String timerRemaining(String time) {
    return 'Осталось: $time';
  }

  @override
  String playingStatus(String time) {
    return 'Воспроизведение · $time';
  }

  @override
  String get pausedStatus => 'Пауза';
}
