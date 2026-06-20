import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
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
    Locale('en'),
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

  /// No description provided for @refreshCatalog.
  ///
  /// In tr, this message translates to:
  /// **'Katalogu yenile'**
  String get refreshCatalog;

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

  /// No description provided for @categoryTurkishLullaby.
  ///
  /// In tr, this message translates to:
  /// **'Türk Ninneleri'**
  String get categoryTurkishLullaby;

  /// No description provided for @categoryLullaby.
  ///
  /// In tr, this message translates to:
  /// **'Ninni'**
  String get categoryLullaby;

  /// No description provided for @categoryClassic.
  ///
  /// In tr, this message translates to:
  /// **'Klasik'**
  String get categoryClassic;

  /// No description provided for @categoryRelaxing.
  ///
  /// In tr, this message translates to:
  /// **'Rahatlatıcı'**
  String get categoryRelaxing;

  /// No description provided for @categoryBackground.
  ///
  /// In tr, this message translates to:
  /// **'Arka Plan'**
  String get categoryBackground;

  /// No description provided for @categoryNational.
  ///
  /// In tr, this message translates to:
  /// **'Dünya Ninneleri'**
  String get categoryNational;

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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
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
