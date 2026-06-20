import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _key = 'favorite_sound_ids';

  Future<Set<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)?.toSet() ?? {};
  }

  Future<void> saveFavorites(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, ids.toList());
  }
}
