import 'dart:async';

import 'package:just_audio/just_audio.dart';

import '../models/sound_item.dart';
import 'audio_playback_config.dart';
import 'sleep_audio_handler.dart';
import 'sound_download_service.dart';

/// Mobile: [SleepAudioHandler] with notification controls.
/// Desktop: local [AudioPlayer] fallback.
class AudioPlayerService {
  AudioPlayerService({
    required SoundDownloadService downloadService,
    SleepAudioHandler? handler,
  })  : _downloadService = downloadService,
        _handler = handler {
    if (_handler == null) {
      _localPlayer = AudioPlayer();
      _localPlayer!.playerStateStream.listen((state) {
        isPlaying = state.playing;
        _syncPlaybackTimer();
        onStateChanged?.call();
      });
    } else {
      _handler!.onStateChanged = () {
        isPlaying = _handler!.isPlaying;
        currentSound = _handler!.currentSound;
        _syncPlaybackTimer();
        onStateChanged?.call();
      };
    }
  }

  final SoundDownloadService _downloadService;
  final SleepAudioHandler? _handler;
  AudioPlayer? _localPlayer;
  final StreamController<Duration> _playbackTimerController =
      StreamController<Duration>.broadcast();
  final Stopwatch _playbackStopwatch = Stopwatch();
  Timer? _playbackTicker;
  Duration _elapsedBeforeCurrentRun = Duration.zero;

  SoundItem? currentSound;
  bool isPlaying = false;
  void Function()? onStateChanged;

  Duration get playbackElapsed =>
      _elapsedBeforeCurrentRun + _playbackStopwatch.elapsed;

  Stream<Duration> get playbackTimerStream => _playbackTimerController.stream;

  Stream<Duration?> get durationStream =>
      _handler?.durationStream ?? _localPlayer!.durationStream;

  Future<void> initSession() async {
    if (_handler != null) {
      await _handler!.initSession();
      return;
    }
    try {
      await configureAudioSessionForPlayback();
      await configurePlayerForPlayback(_localPlayer!);
    } catch (_) {}
  }

  Future<void> play(SoundItem sound, {String? displayTitle, String? albumTitle}) async {
    final isNewSound = currentSound?.id != sound.id;
    if (_handler != null) {
      if (isNewSound) {
        _resetPlaybackTimer();
      }
      await _handler!.playSound(
        sound,
        displayTitle: displayTitle,
        albumTitle: albumTitle,
      );
      currentSound = _handler!.currentSound;
      isPlaying = _handler!.isPlaying;
      _syncPlaybackTimer();
      return;
    }

    if (isNewSound) {
      _resetPlaybackTimer();
      currentSound = sound;
      if (sound.isBundled) {
        await _localPlayer!.setAsset(sound.assetPath!);
      } else {
        final file = await _downloadService.resolveLocalFile(sound);
        await _localPlayer!.setFilePath(file.path);
      }
      await _localPlayer!.setLoopMode(LoopMode.one);
    }
    await _localPlayer!.play();
    isPlaying = true;
    _syncPlaybackTimer();
  }

  Future<void> pause() async {
    if (_handler != null) {
      await _handler!.pause();
    } else {
      await _localPlayer!.pause();
    }
    isPlaying = false;
    _syncPlaybackTimer();
  }

  Future<void> toggle(
    SoundItem sound, {
    String? displayTitle,
    String? albumTitle,
  }) async {
    final isNewSound = currentSound?.id != sound.id;
    if (_handler != null) {
      if (isNewSound) {
        _resetPlaybackTimer();
      }
      await _handler!.toggle(
        sound,
        displayTitle: displayTitle,
        albumTitle: albumTitle,
      );
      currentSound = _handler!.currentSound;
      isPlaying = _handler!.isPlaying;
      _syncPlaybackTimer();
      return;
    }
    if (currentSound?.id == sound.id && isPlaying) {
      await pause();
    } else {
      await play(sound);
    }
  }

  Future<void> setVolume(double volume) async {
    if (_handler != null) {
      await _handler!.setVolume(volume);
    } else {
      await _localPlayer!.setVolume(volume.clamp(0.0, 1.0));
    }
  }

  Future<void> stop() async {
    if (_handler != null) {
      await _handler!.stopPlayback();
      currentSound = _handler!.currentSound;
    } else {
      await _localPlayer!.stop();
      currentSound = null;
    }
    isPlaying = false;
    _resetPlaybackTimer();
  }

  void configureSkipHandlers({
    Future<void> Function()? onNext,
    Future<void> Function()? onPrevious,
  }) {
    _handler?.onSkipToNext = onNext;
    _handler?.onSkipToPrevious = onPrevious;
  }

  void updatePlaylistControls({
    required bool hasNext,
    required bool hasPrevious,
  }) {
    _handler?.updateSkipControls(hasNext: hasNext, hasPrevious: hasPrevious);
  }

  void dispose() {
    _resetPlaybackTimer();
    _playbackTimerController.close();
    _handler?.disposeHandler();
    _localPlayer?.dispose();
  }

  void _syncPlaybackTimer() {
    if (currentSound != null && isPlaying) {
      _startPlaybackTimer();
    } else {
      _pausePlaybackTimer();
    }
  }

  void _startPlaybackTimer() {
    if (!_playbackStopwatch.isRunning) {
      _playbackStopwatch.start();
    }
    _playbackTicker ??= Timer.periodic(const Duration(seconds: 1), (_) {
      _emitPlaybackElapsed();
    });
    _emitPlaybackElapsed();
  }

  void _pausePlaybackTimer() {
    if (_playbackStopwatch.isRunning) {
      _elapsedBeforeCurrentRun += _playbackStopwatch.elapsed;
      _playbackStopwatch
        ..stop()
        ..reset();
    }
    _playbackTicker?.cancel();
    _playbackTicker = null;
    _emitPlaybackElapsed();
  }

  void _resetPlaybackTimer() {
    _playbackTicker?.cancel();
    _playbackTicker = null;
    _playbackStopwatch
      ..stop()
      ..reset();
    _elapsedBeforeCurrentRun = Duration.zero;
    _emitPlaybackElapsed();
  }

  void _emitPlaybackElapsed() {
    if (!_playbackTimerController.isClosed) {
      _playbackTimerController.add(playbackElapsed);
    }
  }
}
