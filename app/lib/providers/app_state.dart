import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/sound_catalog.dart';
import '../models/sound_category.dart';
import '../models/sound_item.dart';
import '../services/app_review_service.dart';
import '../services/audio_player_service.dart';
import '../services/favorites_service.dart';
import '../services/notification_permission.dart';
import '../services/remote_catalog_service.dart';
import '../services/sound_download_service.dart';

class AppState extends ChangeNotifier {
  AppState({
    required AudioPlayerService audioService,
    required FavoritesService favoritesService,
    required SoundDownloadService downloadService,
    required RemoteCatalogService remoteCatalogService,
    AppReviewService? appReviewService,
  })  : _audioService = audioService,
        _favoritesService = favoritesService,
        _downloadService = downloadService,
        _remoteCatalogService = remoteCatalogService,
        _appReviewService = appReviewService ?? AppReviewService(enabled: false) {
    _audioService.onStateChanged = notifyListeners;
  }

  final AudioPlayerService _audioService;
  final FavoritesService _favoritesService;
  final SoundDownloadService _downloadService;
  final RemoteCatalogService _remoteCatalogService;
  final AppReviewService _appReviewService;

  Set<String> _favoriteIds = {};
  final Set<String> _cachedRemoteIds = {};
  List<SoundItem> _remoteSounds = [];
  String? _loadingSoundId;
  bool _isRefreshingCatalog = false;
  bool _notificationPermissionRequested = false;
  static const _keyLastSleepTimerMinutes = 'sleep_timer_last_duration_minutes';

  Timer? _sleepTimer;
  Duration? _timerRemaining;
  Duration? _timerDuration;
  Duration? _lastSleepTimerDuration;
  double _volume = 0.8;

  List<SoundItem> _playlist = [];
  int _playlistIndex = 0;

  List<SoundCategory> get categories => SoundCatalog.categories;

  List<SoundCategory> get visibleCategories {
    return categories.where((category) => soundsFor(category.id).isNotEmpty).toList();
  }
  Set<String> get favoriteIds => _favoriteIds;
  List<SoundItem> get allSounds => SoundCatalog.mergeWithRemote(_remoteSounds);
  SoundItem? get currentSound => _audioService.currentSound;
  bool get isPlaying => _audioService.isPlaying;
  double get volume => _volume;
  Duration? get timerRemaining => _timerRemaining;
  Duration? get timerDuration => _timerDuration;
  Duration? get lastSleepTimerDuration => _lastSleepTimerDuration;
  bool get hasActiveTimer => _timerRemaining != null;
  String? get loadingSoundId => _loadingSoundId;
  bool get isRefreshingCatalog => _isRefreshingCatalog;
  Duration get playbackElapsed => _audioService.playbackElapsed;

  Stream<Duration> get playbackTimerStream => _audioService.playbackTimerStream;
  Stream<Duration?> get durationStream => _audioService.durationStream;

  List<SoundItem> get playlist => List.unmodifiable(_playlist);
  int get playlistIndex => _playlistIndex;
  bool get hasPlaylistNavigation => _playlist.length > 1;
  bool get canSkipToNext =>
      hasPlaylistNavigation && _playlistIndex < _playlist.length - 1;
  bool get canSkipToPrevious => hasPlaylistNavigation && _playlistIndex > 0;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final lastMinutes = prefs.getInt(_keyLastSleepTimerMinutes);
    if (lastMinutes != null) {
      _lastSleepTimerDuration = Duration(minutes: lastMinutes);
    }

    await _audioService.initSession();
    _audioService.configureSkipHandlers(
      onNext: () => skipToNextTrack(),
      onPrevious: () => skipToPreviousTrack(),
    );
    await _audioService.setVolume(_volume);
    _favoriteIds = await _favoritesService.loadFavorites();
    await refreshRemoteCatalog();
  }

  Future<CatalogRefreshResult?> refreshRemoteCatalog() async {
    if (_isRefreshingCatalog) return null;

    _isRefreshingCatalog = true;
    notifyListeners();

    try {
      final previousCount = _remoteSounds.length;
      final loadResult = await _remoteCatalogService.loadWithStatus();
      _remoteSounds = loadResult.sounds;
      await _refreshCachedRemoteIds();
      notifyListeners();
      return CatalogRefreshResult(
        source: loadResult.source,
        previousCount: previousCount,
        newCount: _remoteSounds.length,
      );
    } finally {
      _isRefreshingCatalog = false;
      notifyListeners();
    }
  }

  Future<void> _refreshCachedRemoteIds() async {
    _cachedRemoteIds.removeWhere((id) => !_remoteSounds.any((s) => s.id == id));
    for (final sound in _remoteSounds) {
      if (await _downloadService.isDownloaded(sound)) {
        _cachedRemoteIds.add(sound.id);
      }
    }
  }

  List<SoundItem> soundsFor(SoundCategoryId categoryId) {
    return SoundCatalog.soundsFor(allSounds, categoryId);
  }

  List<SoundItem> get favoriteSounds {
    return allSounds.where((sound) => _favoriteIds.contains(sound.id)).toList();
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

  Future<void> playSound(
    SoundItem sound, {
    String? displayTitle,
    List<SoundItem>? playlist,
  }) async {
    await _ensurePlaybackPermission();

    if (playlist != null && playlist.isNotEmpty) {
      _setPlaylist(playlist, sound.id);
    } else {
      _setPlaylist([sound], sound.id);
    }
    _syncPlaylistControls();

    _loadingSoundId = sound.id;
    notifyListeners();
    try {
      await _audioService.play(sound, displayTitle: displayTitle);
      if (sound.isRemote) {
        _cachedRemoteIds.add(sound.id);
      }
      await _appReviewService.recordPlaybackSession();
      await _appReviewService.maybeRequestReview();
    } finally {
      if (_loadingSoundId == sound.id) {
        _loadingSoundId = null;
      }
      notifyListeners();
    }
  }

  Future<void> playPlaylist(List<SoundItem> sounds, {int startIndex = 0}) async {
    if (sounds.isEmpty) return;
    final index = startIndex.clamp(0, sounds.length - 1);
    await playSound(sounds[index], playlist: sounds);
  }

  Future<void> skipToNextTrack({String? displayTitle}) async {
    if (!canSkipToNext) return;
    _playlistIndex++;
    await _playPlaylistItem(displayTitle);
  }

  Future<void> skipToPreviousTrack({String? displayTitle}) async {
    if (!canSkipToPrevious) return;
    _playlistIndex--;
    await _playPlaylistItem(displayTitle);
  }

  Future<void> _playPlaylistItem(String? displayTitle) async {
    await _ensurePlaybackPermission();

    final sound = _playlist[_playlistIndex];
    _loadingSoundId = sound.id;
    _syncPlaylistControls();
    notifyListeners();
    try {
      await _audioService.play(sound, displayTitle: displayTitle ?? sound.name);
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

  void _setPlaylist(List<SoundItem> sounds, String activeSoundId) {
    _playlist = List<SoundItem>.from(sounds);
    final index = _playlist.indexWhere((sound) => sound.id == activeSoundId);
    _playlistIndex = index >= 0 ? index : 0;
  }

  void _syncPlaylistControls() {
    _audioService.updatePlaylistControls(
      hasNext: canSkipToNext,
      hasPrevious: canSkipToPrevious,
    );
  }

  Future<void> togglePlayback(SoundItem sound, {String? displayTitle}) async {
    final willStart = currentSound?.id != sound.id || !isPlaying;
    if (willStart) {
      await _ensurePlaybackPermission();
    }
    await _audioService.toggle(sound, displayTitle: displayTitle);
  }

  Future<void> _ensurePlaybackPermission() async {
    if (_notificationPermissionRequested) return;
    _notificationPermissionRequested = true;
    await ensureNotificationPermission();
  }

  Future<void> pause() => _audioService.pause();

  Future<bool> requestAppReview() => _appReviewService.requestReviewManually();

  Future<void> setVolume(double value) async {
    _volume = value;
    await _audioService.setVolume(value);
    notifyListeners();
  }

  void startSleepTimer(Duration duration) {
    _sleepTimer?.cancel();
    _timerDuration = duration;
    _timerRemaining = duration;
    _lastSleepTimerDuration = duration;
    unawaited(_persistLastSleepTimerDuration(duration));
    notifyListeners();

    _sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerRemaining == null) {
        timer.cancel();
        return;
      }

      if (!_audioService.isPlaying) {
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
    _timerDuration = null;
  }

  Future<void> _persistLastSleepTimerDuration(Duration duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyLastSleepTimerMinutes, duration.inMinutes);
  }

  @override
  void dispose() {
    _clearTimer();
    _audioService.dispose();
    super.dispose();
  }
}

class CatalogRefreshResult {
  const CatalogRefreshResult({
    required this.source,
    required this.previousCount,
    required this.newCount,
  });

  final CatalogSource source;
  final int previousCount;
  final int newCount;

  bool get hasChanges => previousCount != newCount;
}
