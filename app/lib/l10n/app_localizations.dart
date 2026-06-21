import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ru'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bebek Uyku Sesleri'**
  String get appTitle;

  /// No description provided for @favorites.
  ///
  /// In tr, this message translates to:
  /// **'Favoriler'**
  String get favorites;

  /// No description provided for @playlist.
  ///
  /// In tr, this message translates to:
  /// **'Çalma listesi'**
  String get playlist;

  /// No description provided for @playAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü çal'**
  String get playAll;

  /// No description provided for @playlistHint.
  ///
  /// In tr, this message translates to:
  /// **'Favori sesler sırayla çalar. Sonraki ve önceki ile parça değiştirebilirsin.'**
  String get playlistHint;

  /// No description provided for @nextTrack.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki parça'**
  String get nextTrack;

  /// No description provided for @previousTrack.
  ///
  /// In tr, this message translates to:
  /// **'Önceki parça'**
  String get previousTrack;

  /// No description provided for @refreshCatalog.
  ///
  /// In tr, this message translates to:
  /// **'Katalogu yenile'**
  String get refreshCatalog;

  /// No description provided for @refreshCatalogInProgress.
  ///
  /// In tr, this message translates to:
  /// **'Katalog yenileniyor…'**
  String get refreshCatalogInProgress;

  /// No description provided for @refreshCatalogUpdated.
  ///
  /// In tr, this message translates to:
  /// **'Katalog güncellendi · {count} çevrimiçi ses'**
  String refreshCatalogUpdated(int count);

  /// No description provided for @refreshCatalogUpToDate.
  ///
  /// In tr, this message translates to:
  /// **'Katalog zaten güncel.'**
  String get refreshCatalogUpToDate;

  /// No description provided for @refreshCatalogUsedCache.
  ///
  /// In tr, this message translates to:
  /// **'Sunucuya ulaşılamadı. Kayıtlı katalog gösteriliyor ({count} ses).'**
  String refreshCatalogUsedCache(int count);

  /// No description provided for @refreshCatalogOffline.
  ///
  /// In tr, this message translates to:
  /// **'Çevrimdışı. Yerel katalog kullanılıyor ({count} ses).'**
  String refreshCatalogOffline(int count);

  /// No description provided for @language.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @systemLanguage.
  ///
  /// In tr, this message translates to:
  /// **'Telefon dili'**
  String get systemLanguage;

  /// No description provided for @turkish.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get turkish;

  /// No description provided for @english.
  ///
  /// In tr, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In tr, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @french.
  ///
  /// In tr, this message translates to:
  /// **'Français'**
  String get french;

  /// No description provided for @german.
  ///
  /// In tr, this message translates to:
  /// **'Deutsch'**
  String get german;

  /// No description provided for @italian.
  ///
  /// In tr, this message translates to:
  /// **'Italiano'**
  String get italian;

  /// No description provided for @russian.
  ///
  /// In tr, this message translates to:
  /// **'Русский'**
  String get russian;

  /// No description provided for @arabic.
  ///
  /// In tr, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @soundCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} ses'**
  String soundCount(int count);

  /// No description provided for @categoryWhiteNoise.
  ///
  /// In tr, this message translates to:
  /// **'Beyaz Gürültü'**
  String get categoryWhiteNoise;

  /// No description provided for @categoryLullaby.
  ///
  /// In tr, this message translates to:
  /// **'Ninniler'**
  String get categoryLullaby;

  /// No description provided for @categoryRelaxing.
  ///
  /// In tr, this message translates to:
  /// **'Rahatlatıcı'**
  String get categoryRelaxing;

  /// No description provided for @categoryMusic.
  ///
  /// In tr, this message translates to:
  /// **'Müzik'**
  String get categoryMusic;

  /// No description provided for @homeHeaderSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Huzurlu uykular için'**
  String get homeHeaderSubtitle;

  /// No description provided for @developedBy.
  ///
  /// In tr, this message translates to:
  /// **'Tngr Studio'**
  String get developedBy;

  /// No description provided for @versionLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sürüm {version}'**
  String versionLabel(String version);

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz favori yok'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Ses listesindeki kalbe dokunarak ekleyebilirsin.'**
  String get favoritesEmptyBody;

  /// No description provided for @emptyCategory.
  ///
  /// In tr, this message translates to:
  /// **'Bu kategoride ses yok'**
  String get emptyCategory;

  /// No description provided for @downloadOnFirstPlay.
  ///
  /// In tr, this message translates to:
  /// **'İlk dinlemede indirilir'**
  String get downloadOnFirstPlay;

  /// No description provided for @downloadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Ses indirilemedi: {error}'**
  String downloadFailed(String error);

  /// No description provided for @sleepTimer.
  ///
  /// In tr, this message translates to:
  /// **'Uyku Zamanlayıcısı'**
  String get sleepTimer;

  /// No description provided for @sleepTimerHint.
  ///
  /// In tr, this message translates to:
  /// **'Seçilen süre dolana kadar ses tekrar çalar.'**
  String get sleepTimerHint;

  /// No description provided for @minutesOption.
  ///
  /// In tr, this message translates to:
  /// **'{count} dakika'**
  String minutesOption(int count);

  /// No description provided for @unlimited.
  ///
  /// In tr, this message translates to:
  /// **'Sınırsız'**
  String get unlimited;

  /// No description provided for @cancelTimer.
  ///
  /// In tr, this message translates to:
  /// **'Zamanlayıcıyı iptal et'**
  String get cancelTimer;

  /// No description provided for @timerRemaining.
  ///
  /// In tr, this message translates to:
  /// **'Kalan: {time}'**
  String timerRemaining(String time);

  /// No description provided for @playingStatus.
  ///
  /// In tr, this message translates to:
  /// **'Çalıyor · {time}'**
  String playingStatus(String time);

  /// No description provided for @pausedStatus.
  ///
  /// In tr, this message translates to:
  /// **'Duraklatıldı'**
  String get pausedStatus;

  /// No description provided for @supportMenu.
  ///
  /// In tr, this message translates to:
  /// **'Gönüllü destek'**
  String get supportMenu;

  /// No description provided for @supportLink.
  ///
  /// In tr, this message translates to:
  /// **'Geliştirmeyi destekle'**
  String get supportLink;

  /// No description provided for @supportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gönüllü destek'**
  String get supportTitle;

  /// No description provided for @supportBody.
  ///
  /// In tr, this message translates to:
  /// **'Bu uygulama reklamsız ve tamamen ücretsiz. Beğendiysen geliştirmeyi gönüllü olarak destekleyebilirsin. Hiçbir özellik kilitli değildir.'**
  String get supportBody;

  /// No description provided for @supportCoffeeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bir kahve'**
  String get supportCoffeeTitle;

  /// No description provided for @supportCoffeeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Küçük bir teşekkür'**
  String get supportCoffeeSubtitle;

  /// No description provided for @supportMealTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bir öğün'**
  String get supportMealTitle;

  /// No description provided for @supportMealSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Geliştirmeyi destekle'**
  String get supportMealSubtitle;

  /// No description provided for @supportGenerousTitle.
  ///
  /// In tr, this message translates to:
  /// **'Cömert destek'**
  String get supportGenerousTitle;

  /// No description provided for @supportGenerousSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Ekstra teşekkürler'**
  String get supportGenerousSubtitle;

  /// No description provided for @supportThankYou.
  ///
  /// In tr, this message translates to:
  /// **'Desteğin için teşekkürler!'**
  String get supportThankYou;

  /// No description provided for @supportUnavailable.
  ///
  /// In tr, this message translates to:
  /// **'Destek seçenekleri şu an kullanılamıyor. Daha sonra tekrar dene.'**
  String get supportUnavailable;

  /// No description provided for @supportProductsPending.
  ///
  /// In tr, this message translates to:
  /// **'Satın alma, Play Console\'da ürünler etkinleştirildikten ve uygulama test kanalına yüklendikten sonra açılır.'**
  String get supportProductsPending;

  /// No description provided for @supportPricePending.
  ///
  /// In tr, this message translates to:
  /// **'Yakında'**
  String get supportPricePending;

  /// No description provided for @supportPurchasing.
  ///
  /// In tr, this message translates to:
  /// **'İşleniyor…'**
  String get supportPurchasing;

  /// No description provided for @supportPurchaseFailed.
  ///
  /// In tr, this message translates to:
  /// **'Satın alma tamamlanamadı. Lütfen tekrar dene.'**
  String get supportPurchaseFailed;

  /// No description provided for @homeSupportCta.
  ///
  /// In tr, this message translates to:
  /// **'Bir kahve ısmarla'**
  String get homeSupportCta;

  /// No description provided for @homeSupportHint.
  ///
  /// In tr, this message translates to:
  /// **'Gönüllü destek · Reklamsız uygulama'**
  String get homeSupportHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ru',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
