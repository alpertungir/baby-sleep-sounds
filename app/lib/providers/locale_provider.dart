import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider({Locale? systemLocale}) : _systemLocale = systemLocale;

  static const _key = 'app_locale';

  final Locale? _systemLocale;
  Locale? _override;

  Locale? get locale => _override;

  Locale get effectiveLocale {
    if (_override != null) return _override!;
    return _resolveSystemLocale(_systemLocale);
  }

  bool get usesSystemLocale => _override == null;

  static Locale _resolveSystemLocale(Locale? system) {
    final code = system?.languageCode ?? 'tr';
    if (code == 'tr') return const Locale('tr');
    return const Locale('en');
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code == 'tr' || code == 'en') {
      _override = Locale(code!);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    _override = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }

  Future<void> useSystemLocale() async {
    _override = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
