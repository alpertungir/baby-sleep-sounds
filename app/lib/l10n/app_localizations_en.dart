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
  String get playlist => 'Playlist';

  @override
  String get playAll => 'Play all';

  @override
  String get playlistHint =>
      'Favorite sounds play in order. Skip tracks with next and previous.';

  @override
  String get nextTrack => 'Next track';

  @override
  String get previousTrack => 'Previous track';

  @override
  String get refreshCatalog => 'Refresh catalog';

  @override
  String get refreshCatalogInProgress => 'Refreshing catalog…';

  @override
  String refreshCatalogUpdated(int count) {
    return 'Catalog updated · $count sounds';
  }

  @override
  String get refreshCatalogUpToDate => 'Catalog is already up to date.';

  @override
  String refreshCatalogUsedCache(int count) {
    return 'Could not reach server. Showing saved catalog ($count sounds).';
  }

  @override
  String refreshCatalogOffline(int count) {
    return 'Offline. Using bundled catalog ($count sounds).';
  }

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
  String get developedBy => 'Tngr Studio';

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

  @override
  String get supportMenu => 'Support development';

  @override
  String get rateApp => 'Rate the app';

  @override
  String get rateAppUnavailable =>
      'Rating is not available on this device. Try again from the Play Store.';

  @override
  String get supportLink => 'Support development';

  @override
  String get supportTitle => 'Voluntary support';

  @override
  String get supportBody =>
      'This app is free and ad-free. If you enjoy it, you can voluntarily support development. No features are locked.';

  @override
  String get supportCoffeeTitle => 'Buy me a coffee';

  @override
  String get supportCoffeeSubtitle => 'A small thank-you';

  @override
  String get supportMealTitle => 'Buy me a meal';

  @override
  String get supportMealSubtitle => 'Support development';

  @override
  String get supportGenerousTitle => 'Generous support';

  @override
  String get supportGenerousSubtitle => 'Extra thanks';

  @override
  String get supportThankYou => 'Thank you for your support!';

  @override
  String get supportUnavailable =>
      'Support options are not available right now. Please try again later.';

  @override
  String get supportProductsPending =>
      'Purchases unlock after in-app products are active in Play Console and the app is on a test track.';

  @override
  String get supportPricePending => 'Soon';

  @override
  String get supportPurchasing => 'Processing…';

  @override
  String get supportPurchaseFailed =>
      'Purchase could not be completed. Please try again.';

  @override
  String get homeSupportCta => 'Buy me a coffee';

  @override
  String get homeSupportHint => 'Voluntary support · Ad-free app';
}
