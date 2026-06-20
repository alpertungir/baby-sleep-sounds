import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import '../models/sound_item.dart';
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
        onStateChanged?.call();
      });
      _localPlayer!.positionStream.listen((_) => onStateChanged?.call());
    } else {
      _handler!.onStateChanged = () {
        isPlaying = _handler!.isPlaying;
        currentSound = _handler!.currentSound;
        onStateChanged?.call();
      };
    }
  }

  final SoundDownloadService _downloadService;
  final SleepAudioHandler? _handler;
  AudioPlayer? _localPlayer;

  SoundItem? currentSound;
  bool isPlaying = false;
  void Function()? onStateChanged;

  Stream<Duration> get positionStream =>
      _handler?.positionStream ?? _localPlayer!.positionStream;

  Stream<Duration?> get durationStream =>
      _handler?.durationStream ?? _localPlayer!.durationStream;

  Future<void> initSession() async {
    if (_handler != null) {
      await _handler!.initSession();
      return;
    }
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
    } catch (_) {}
  }

  Future<void> play(SoundItem sound) async {
    if (_handler != null) {
      await _handler!.playSound(sound);
      currentSound = _handler!.currentSound;
      isPlaying = _handler!.isPlaying;
      return;
    }

    if (currentSound?.id != sound.id) {
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
  }

  Future<void> pause() async {
    if (_handler != null) {
      await _handler!.pause();
    } else {
      await _localPlayer!.pause();
    }
    isPlaying = false;
  }

  Future<void> toggle(SoundItem sound) async {
    if (_handler != null) {
      await _handler!.toggle(sound);
      currentSound = _handler!.currentSound;
      isPlaying = _handler!.isPlaying;
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
    } else {
      await _localPlayer!.stop();
      currentSound = null;
    }
    isPlaying = false;
  }

  void dispose() {
    _handler?.disposeHandler();
    _localPlayer?.dispose();
  }
}
