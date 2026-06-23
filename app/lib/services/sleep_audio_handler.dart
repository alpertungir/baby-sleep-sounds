import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart' as audio_session;
import 'package:just_audio/just_audio.dart';

import '../config/app_identity.dart';
import '../models/sound_item.dart';
import 'audio_playback_config.dart';
import 'media_artwork_resolver.dart';
import 'sound_download_service.dart';

/// Spotify-style playback: just_audio drives a MediaSession foreground service
/// via audio_service. State is broadcast only through [playbackState].pipe.
class SleepAudioHandler extends BaseAudioHandler with SeekHandler {
  SleepAudioHandler(this._downloadService) {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _player.playerStateStream.listen((state) {
      isPlaying = state.playing;
      onStateChanged?.call();
    });
  }

  final SoundDownloadService _downloadService;
  final AudioPlayer _player = AudioPlayer();

  SoundItem? currentSound;
  bool isPlaying = false;
  void Function()? onStateChanged;
  Future<void> Function()? onSkipToNext;
  Future<void> Function()? onSkipToPrevious;
  bool _hasNext = false;
  bool _hasPrevious = false;

  AudioPlayer get player => _player;
  Stream<Duration?> get durationStream => _player.durationStream;

  Future<void> initSession() async {
    await configureAudioSessionForPlayback();
    await configurePlayerForPlayback(_player);

    final session = await audio_session.AudioSession.instance;
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case audio_session.AudioInterruptionType.duck:
          case audio_session.AudioInterruptionType.pause:
          case audio_session.AudioInterruptionType.unknown:
            if (_player.playing) pause();
        }
      }
    });
  }

  Future<void> playSound(
    SoundItem sound, {
    String? displayTitle,
    String? albumTitle,
  }) async {
    if (currentSound?.id != sound.id) {
      currentSound = sound;

      final artUri = await resolveMediaArtUri(sound.imagePath);
      final item = MediaItem(
        id: sound.id,
        title: displayTitle ?? sound.name,
        album: albumTitle ?? AppIdentity.mediaAlbumTitle,
        artist: AppIdentity.studioName,
        artUri: artUri,
        playable: true,
      );
      mediaItem.add(item);

      if (sound.isBundled) {
        await _player.setAsset(sound.assetPath!);
      } else {
        final file = await _downloadService.resolveLocalFile(sound);
        await _player.setFilePath(file.path);
      }
      await _player.setLoopMode(LoopMode.one);
    }
    await play();
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

  Future<void> setVolume(double volume) =>
      _player.setVolume(volume.clamp(0.0, 1.0));

  Future<void> stopPlayback() => stop();

  @override
  Future<void> play() async {
    final session = await audio_session.AudioSession.instance;
    await session.setActive(true);
    await _player.play();
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> onTaskRemoved() async {
    // Keep active playback alive, but do not leave a stale paused notification.
    if (!_player.playing) {
      await stop();
    }
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    currentSound = null;
    isPlaying = false;
    mediaItem.add(null);
    _publishStoppedState();
    onStateChanged?.call();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  void updateSkipControls({required bool hasNext, required bool hasPrevious}) {
    _hasNext = hasNext;
    _hasPrevious = hasPrevious;
    _refreshPlaybackState();
  }

  @override
  Future<void> skipToNext() => onSkipToNext?.call() ?? Future.value();

  @override
  Future<void> skipToPrevious() => onSkipToPrevious?.call() ?? Future.value();

  void _refreshPlaybackState() {
    if (_player.processingState == ProcessingState.idle) return;
    unawaited(_player.seek(_player.position));
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
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

    return PlaybackState(
      controls: controls,
      systemActions: const {
        MediaAction.seek,
        MediaAction.stop,
      },
      androidCompactActionIndices: compactIndices,
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }

  void _publishStoppedState() {
    playbackState.add(
      playbackState.value.copyWith(
        controls: const [],
        systemActions: const {},
        androidCompactActionIndices: const [],
        processingState: AudioProcessingState.idle,
        playing: false,
        updatePosition: Duration.zero,
        bufferedPosition: Duration.zero,
      ),
    );
  }

  Future<void> disposeHandler() async {
    await _player.dispose();
  }
}
