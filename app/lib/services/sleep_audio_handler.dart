import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../config/app_identity.dart';
import '../models/sound_item.dart';
import 'audio_playback_config.dart';
import 'sound_download_service.dart';

class SleepAudioHandler extends BaseAudioHandler with SeekHandler {
  SleepAudioHandler(this._downloadService) {
    _player.playbackEventStream.listen(_broadcastState);
    _player.playerStateStream.listen((_) => _broadcastState(_player.playbackEvent));
  }

  final SoundDownloadService _downloadService;
  final AudioPlayer _player = AudioPlayer();
  final Stopwatch _elapsedStopwatch = Stopwatch();
  Timer? _stateTicker;
  Duration _elapsedBeforeCurrentRun = Duration.zero;

  SoundItem? currentSound;
  bool isPlaying = false;
  void Function()? onStateChanged;
  Future<void> Function()? onSkipToNext;
  Future<void> Function()? onSkipToPrevious;
  bool _hasNext = false;
  bool _hasPrevious = false;

  AudioPlayer get player => _player;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  Duration get _sessionPosition =>
      _elapsedBeforeCurrentRun + _elapsedStopwatch.elapsed;

  Future<void> initSession() async {
    await configureAudioSessionForPlayback();
    await configurePlayerForPlayback(_player);
  }

  Future<void> playSound(
    SoundItem sound, {
    String? displayTitle,
    String? albumTitle,
  }) async {
    if (currentSound?.id != sound.id) {
      currentSound = sound;
      _resetElapsed();
      if (sound.isBundled) {
        await _player.setAsset(sound.assetPath!);
      } else {
        final file = await _downloadService.resolveLocalFile(sound);
        await _player.setFilePath(file.path);
      }
      await _player.setLoopMode(LoopMode.one);
      mediaItem.add(
        MediaItem(
          id: sound.id,
          title: displayTitle ?? sound.name,
          album: albumTitle ?? AppIdentity.mediaAlbumTitle,
          artUri: Uri.parse('asset:///${sound.imagePath}'),
        ),
      );
    }
    await _player.play();
    _syncElapsedTicker();
  }

  Future<void> toggle(
    SoundItem sound, {
    String? displayTitle,
    String? albumTitle,
  }) async {
    if (currentSound?.id == sound.id && _player.playing) {
      await pause();
    } else {
      await playSound(
        sound,
        displayTitle: displayTitle,
        albumTitle: albumTitle,
      );
    }
  }

  Future<void> setVolume(double volume) => _player.setVolume(volume.clamp(0.0, 1.0));

  Future<void> stopPlayback() async {
    await _player.stop();
    currentSound = null;
    _resetElapsed();
    await stop();
  }

  @override
  Future<void> play() async {
    await _player.play();
    _syncElapsedTicker();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    _syncElapsedTicker();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    currentSound = null;
    _resetElapsed();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  void updateSkipControls({required bool hasNext, required bool hasPrevious}) {
    _hasNext = hasNext;
    _hasPrevious = hasPrevious;
    _broadcastState(_player.playbackEvent);
  }

  @override
  Future<void> skipToNext() => onSkipToNext?.call() ?? Future.value();

  @override
  Future<void> skipToPrevious() => onSkipToPrevious?.call() ?? Future.value();

  void _broadcastState(PlaybackEvent event) {
    isPlaying = _player.playing;
    onStateChanged?.call();

    final controls = <MediaControl>[
      if (_hasPrevious) MediaControl.skipToPrevious,
      if (_player.playing) MediaControl.pause else MediaControl.play,
      if (_hasNext) MediaControl.skipToNext,
      MediaControl.stop,
    ];
    final compactIndices = _hasPrevious && _hasNext
        ? const [0, 1, 2]
        : (_hasPrevious || _hasNext)
            ? const [0, 1]
            : const [0];

    playbackState.add(
      playbackState.value.copyWith(
        controls: controls,
        systemActions: const {MediaAction.stop},
        androidCompactActionIndices: compactIndices,
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: _player.playing,
        updatePosition: _sessionPosition,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }

  void _syncElapsedTicker() {
    if (currentSound != null && _player.playing) {
      if (!_elapsedStopwatch.isRunning) {
        _elapsedStopwatch.start();
      }
      _stateTicker ??= Timer.periodic(const Duration(seconds: 1), (_) {
        _broadcastState(_player.playbackEvent);
      });
      _broadcastState(_player.playbackEvent);
      return;
    }

    if (_elapsedStopwatch.isRunning) {
      _elapsedBeforeCurrentRun += _elapsedStopwatch.elapsed;
      _elapsedStopwatch
        ..stop()
        ..reset();
    }
    _stateTicker?.cancel();
    _stateTicker = null;
    _broadcastState(_player.playbackEvent);
  }

  void _resetElapsed() {
    _stateTicker?.cancel();
    _stateTicker = null;
    _elapsedStopwatch
      ..stop()
      ..reset();
    _elapsedBeforeCurrentRun = Duration.zero;
  }

  Future<void> disposeHandler() async {
    _resetElapsed();
    await _player.dispose();
  }
}
