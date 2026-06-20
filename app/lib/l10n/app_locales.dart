import 'package:flutter/material.dart';

import 'app_localizations.dart';

/// Supported UI locales. Sound names fall back to English except Turkish.
class AppLocales {
  AppLocales._();

  static const codes = ['tr', 'en', 'es', 'fr', 'de', 'it', 'ru', 'ar'];

  static const supported = [
    Locale('tr'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('de'),
    Locale('it'),
    Locale('ru'),
    Locale('ar'),
  ];

  static bool isSupported(String? languageCode) {
    return languageCode != null && codes.contains(languageCode);
  }

  static Locale resolve(Locale? system) {
    final code = system?.languageCode;
    if (isSupported(code)) return Locale(code!);
    return const Locale('en');
  }

  static String label(AppLocalizations l10n, String code) {
    return switch (code) {
      'tr' => l10n.turkish,
      'en' => l10n.english,
      'es' => l10n.spanish,
      'fr' => l10n.french,
      'de' => l10n.german,
      'it' => l10n.italian,
      'ru' => l10n.russian,
      'ar' => l10n.arabic,
      _ => l10n.english,
    };
  }
}
