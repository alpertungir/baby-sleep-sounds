import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/sound_catalog.dart';
import '../models/sound_category.dart';
import '../models/sound_item.dart';
import '../services/audio_player_service.dart';
import '../services/favorites_service.dart';
import '../services/sound_download_service.dart';

class AppState extends ChangeNotifier {
  AppState({
    required AudioPlayerService audioService,
    required FavoritesService favoritesService,
    required SoundDownloadService downloadService,
  })  : _audioService = audioService,
        _favoritesService = favoritesService,
        _downloadService = downloadService {
    _audioService.onStateChanged = notifyListeners;
  }

  final AudioPlayerService _audioService;
  final FavoritesService _favoritesService;
  final SoundDownloadService _downloadService;

  Set<String> _favoriteIds = {};
  final Set<String> _cachedRemoteIds = {};
  String? _loadingSoundId;
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
  String? get loadingSoundId => _loadingSoundId;

  Stream<Duration> get positionStream => _audioService.positionStream;
  Stream<Duration?> get durationStream => _audioService.durationStream;

  Future<void> initialize() async {
    await _audioService.initSession();
    await _audioService.setVolume(_volume);
    _favoriteIds = await _favoritesService.loadFavorites();
    await _refreshCachedRemoteIds();
    notifyListeners();
  }

  Future<void> _refreshCachedRemoteIds() async {
    for (final sound in SoundCatalog.sounds) {
      if (sound.isRemote && await _downloadService.isDownloaded(sound)) {
        _cachedRemoteIds.add(sound.id);
      }
    }
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

  bool isCached(SoundItem sound) {
    return sound.isBundled || _cachedRemoteIds.contains(sound.id);
  }

  bool isLoading(SoundItem sound) => _loadingSoundId == sound.id;

  Future<void> toggleFavorite(String soundId) async {
    if (_favoriteIds.contains(soundId)) {
      _favoriteIds.remove(soundId);
    } else {
      _favoriteIds.add(soundId);
    }
    await _favoritesService.saveFavorites(_favoriteIds);
    notifyListeners();
  }

  Future<void> playSound(SoundItem sound) async {
    _loadingSoundId = sound.id;
    notifyListeners();
    try {
      await _audioService.play(sound);
      if (sound.isRemote) {
        _cachedRemoteIds.add(sound.id);
      }
    } finally {
      if (_loadingSoundId == sound.id) {
        _loadingSoundId = null;
      }
      notifyListeners();
    }
  }

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
