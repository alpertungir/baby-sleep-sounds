import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sound_category.dart';
import '../models/sound_item.dart';

class RemoteCatalogService {
  RemoteCatalogService({FirebaseStorage? storage}) : _storage = storage;

  static const catalogStoragePath = 'sounds/catalog.json';
  static const cacheKey = 'remote_catalog_json';
  static const fallbackAsset = 'assets/catalog_fallback.json';

  final FirebaseStorage? _storage;

  FirebaseStorage get _storageOrThrow {
    if (_storage != null) return _storage;
    if (Firebase.apps.isEmpty) {
      throw StateError('Firebase yapılandırılmamış.');
    }
    return FirebaseStorage.instance;
  }

  Future<List<SoundItem>> load() async {
    if (Firebase.apps.isNotEmpty) {
      try {
        final jsonText = await _fetchFromStorage();
        await _saveCache(jsonText);
        return _parse(jsonText);
      } catch (_) {
        final cached = await _loadCache();
        if (cached != null) {
          return _parse(cached);
        }
      }
    }

    return _loadFallback();
  }

  Future<String> _fetchFromStorage() async {
    final ref = _storageOrThrow.ref(catalogStoragePath);
    final data = await ref.getData();
    if (data == null || data.isEmpty) {
      throw StateError('catalog.json boş.');
    }
    return utf8.decode(data);
  }

  Future<void> _saveCache(String jsonText) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonText);
  }

  Future<String?> _loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(cacheKey);
  }

  Future<List<SoundItem>> _loadFallback() async {
    final jsonText = await rootBundle.loadString(fallbackAsset);
    return _parse(jsonText);
  }

  List<SoundItem> _parse(String jsonText) {
    final decoded = jsonDecode(jsonText) as Map<String, dynamic>;
    final sounds = decoded['sounds'] as List<dynamic>? ?? [];
    return sounds
        .map((entry) => _parseSound(entry as Map<String, dynamic>))
        .whereType<SoundItem>()
        .toList();
  }

  SoundItem? _parseSound(Map<String, dynamic> entry) {
    final id = entry['id'] as String?;
    final name = entry['name'] as String?;
    final category = entry['category'] as String?;
    final storagePath = entry['storagePath'] as String?;
    final imagePath = entry['imagePath'] as String?;

    if (id == null ||
        name == null ||
        category == null ||
        storagePath == null ||
        imagePath == null) {
      return null;
    }

    final categoryId = _categoryFromString(category);
    if (categoryId == null) return null;

    return SoundItem(
      id: id,
      name: name,
      categoryId: categoryId,
      storagePath: storagePath,
      imagePath: imagePath,
    );
  }

  SoundCategoryId? _categoryFromString(String value) {
    return switch (value) {
      'background' => SoundCategoryId.background,
      'classic' => SoundCategoryId.classic,
      'national' => SoundCategoryId.national,
      'relaxing' => SoundCategoryId.relaxing,
      _ => null,
    };
  }
}
