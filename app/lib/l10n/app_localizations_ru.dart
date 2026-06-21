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
  String get playlist => 'Плейлист';

  @override
  String get playAll => 'Воспроизвести все';

  @override
  String get playlistHint =>
      'Избранные звуки играют по порядку. Используйте следующий и предыдущий.';

  @override
  String get nextTrack => 'Следующий';

  @override
  String get previousTrack => 'Предыдущий';

  @override
  String get refreshCatalog => 'Обновить каталог';

  @override
  String get refreshCatalogInProgress => 'Обновление каталога…';

  @override
  String refreshCatalogUpdated(int count) {
    return 'Каталог обновлён · $count звуков';
  }

  @override
  String get refreshCatalogUpToDate => 'Каталог уже актуален.';

  @override
  String refreshCatalogUsedCache(int count) {
    return 'Сервер недоступен. Показан сохранённый каталог ($count звуков).';
  }

  @override
  String refreshCatalogOffline(int count) {
    return 'Офлайн. Локальный каталог ($count звуков).';
  }

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
  String get developedBy => 'Tngr Studio';

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

  @override
  String get supportMenu => 'Поддержать разработку';

  @override
  String get rateApp => 'Оценить приложение';

  @override
  String get rateAppUnavailable =>
      'Оценка недоступна на этом устройстве. Попробуйте в Play Store.';

  @override
  String get supportLink => 'Поддержать разработку';

  @override
  String get supportTitle => 'Добровольная поддержка';

  @override
  String get supportBody =>
      'Это приложение бесплатное и без рекламы. Если оно вам нравится, вы можете добровольно поддержать разработку. Ничего не заблокировано.';

  @override
  String get supportCoffeeTitle => 'Кофе';

  @override
  String get supportCoffeeSubtitle => 'Небольшая благодарность';

  @override
  String get supportMealTitle => 'Обед';

  @override
  String get supportMealSubtitle => 'Поддержать разработку';

  @override
  String get supportGenerousTitle => 'Щедрая поддержка';

  @override
  String get supportGenerousSubtitle => 'Особая благодарность';

  @override
  String get supportThankYou => 'Спасибо за поддержку!';

  @override
  String get supportUnavailable =>
      'Варианты поддержки сейчас недоступны. Попробуйте позже.';

  @override
  String get supportProductsPending =>
      'Покупки станут доступны после активации продуктов в Play Console.';

  @override
  String get supportPricePending => 'Скоро';

  @override
  String get supportPurchasing => 'Обработка…';

  @override
  String get supportPurchaseFailed =>
      'Не удалось завершить покупку. Попробуйте снова.';

  @override
  String get homeSupportCta => 'Угостите кофе';

  @override
  String get homeSupportHint => 'Добровольная поддержка · Без рекламы';
}
