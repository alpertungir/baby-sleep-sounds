import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/sound_catalog.dart';
import '../models/sound_category.dart';
import '../models/sound_item.dart';
import '../services/audio_player_service.dart';
import '../services/favorites_service.dart';

class AppState extends ChangeNotifier {
  AppState({
    required AudioPlayerService audioService,
    required FavoritesService favoritesService,
  })  : _audioService = audioService,
        _favoritesService = favoritesService {
    _audioService.onStateChanged = notifyListeners;
  }

  final AudioPlayerService _audioService;
  final FavoritesService _favoritesService;

  Set<String> _favoriteIds = {};
  Timer? _sleepTimer;
  Duration? _timerRemaining;
  double _volume = 0.8;

  List<SoundCategory> get categories => SoundCatalog.categories;
  Set<String> get favoriteIds => _favoriteIds;
  SoundItem? get currentSound => _audioService.currentSound;
  bool get isPlaying => _audioService.isPlaying;
  double get volume => _volume;
  Duration? get timerRemaining => _timerRemaining;
  bool get hasActiveTimer => _timerRemaining != null;

  Stream<Duration> get positionStream => _audioService.positionStream;
  Stream<Duration?> get durationStream => _audioService.durationStream;

  Future<void> initialize() async {
    await _audioService.initSession();
    await _audioService.setVolume(_volume);
    _favoriteIds = await _favoritesService.loadFavorites();
    notifyListeners();
  }

  List<SoundItem> soundsFor(SoundCategoryId categoryId) {
    return SoundCatalog.soundsFor(categoryId);
  }

  List<SoundItem> get favoriteSounds {
    return SoundCatalog.sounds
        .where((sound) => _favoriteIds.contains(sound.id))
        .toList();
  }

  bool isFavorite(String soundId) => _favoriteIds.contains(soundId);

  Future<void> toggleFavorite(String soundId) async {
    if (_favoriteIds.contains(soundId)) {
      _favoriteIds.remove(soundId);
    } else {
      _favoriteIds.add(soundId);
    }
    await _favoritesService.saveFavorites(_favoriteIds);
    notifyListeners();
  }

  Future<void> playSound(SoundItem sound) => _audioService.play(sound);

  Future<void> togglePlayback(SoundItem sound) => _audioService.toggle(sound);

  Future<void> pause() => _audioService.pause();

  Future<void> setVolume(double value) async {
    _volume = value;
    await _audioService.setVolume(value);
    notifyListeners();
  }

  void startSleepTimer(Duration duration) {
    _sleepTimer?.cancel();
    _timerRemaining = duration;
    notifyListeners();

    _sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerRemaining == null) {
        timer.cancel();
        return;
      }

      final next = _timerRemaining! - const Duration(seconds: 1);
      if (next <= Duration.zero) {
        _clearTimer();
        _audioService.stop();
        notifyListeners();
        return;
      }

      _timerRemaining = next;
      notifyListeners();
    });
  }

  void cancelSleepTimer() {
    _clearTimer();
    notifyListeners();
  }

  void _clearTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
    _timerRemaining = null;
  }

  @override
  void dispose() {
    _clearTimer();
    _audioService.dispose();
    super.dispose();
  }
}
