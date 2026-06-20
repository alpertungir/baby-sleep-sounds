import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import '../models/sound_item.dart';
import 'sound_download_service.dart';

class SleepAudioHandler extends BaseAudioHandler with SeekHandler {
  SleepAudioHandler(this._downloadService) {
    _player.playbackEventStream.listen(_broadcastState);
    _player.playerStateStream.listen((_) => _broadcastState(_player.playbackEvent));
  }

  final SoundDownloadService _downloadService;
  final AudioPlayer _player = AudioPlayer();

  SoundItem? currentSound;
  bool isPlaying = false;
  void Function()? onStateChanged;

  AudioPlayer get player => _player;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  Future<void> initSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  Future<void> playSound(SoundItem sound) async {
    if (currentSound?.id != sound.id) {
      currentSound = sound;
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
          title: sound.name,
          album: 'Bebek Uyku Sesleri',
        ),
      );
    }
    await _player.play();
  }

  Future<void> toggle(SoundItem sound) async {
    if (currentSound?.id == sound.id && _player.playing) {
      await pause();
    } else {
      await playSound(sound);
    }
  }

  Future<void> setVolume(double volume) => _player.setVolume(volume.clamp(0.0, 1.0));

  Future<void> stopPlayback() async {
    await _player.stop();
    currentSound = null;
    await stop();
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    currentSound = null;
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  void _broadcastState(PlaybackEvent event) {
    isPlaying = _player.playing;
    onStateChanged?.call();

    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          if (_player.playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
        ],
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: const [0, 1],
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
      ),
    );
  }

  Future<void> disposeHandler() async {
    await _player.dispose();
  }
}
