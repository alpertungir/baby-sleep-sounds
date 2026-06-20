import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import '../models/sound_item.dart';

class AudioPlayerService {
  AudioPlayerService() {
    _player.playerStateStream.listen((state) {
      isPlaying = state.playing;
      onStateChanged?.call();
    });
    _player.positionStream.listen((_) => onStateChanged?.call());
  }

  final AudioPlayer _player = AudioPlayer();
  SoundItem? currentSound;
  bool isPlaying = false;
  void Function()? onStateChanged;

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Duration get position => _player.position;
  Duration? get duration => _player.duration;

  Future<void> initSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  Future<void> play(SoundItem sound) async {
    if (currentSound?.id != sound.id) {
      currentSound = sound;
      await _player.setAsset(sound.audioPath);
      await _player.setLoopMode(LoopMode.one);
    }
    await _player.play();
  }

  Future<void> pause() => _player.pause();

  Future<void> toggle(SoundItem sound) async {
    if (currentSound?.id == sound.id && isPlaying) {
      await pause();
    } else {
      await play(sound);
    }
  }

  Future<void> setVolume(double volume) {
    return _player.setVolume(volume.clamp(0.0, 1.0));
  }

  Future<void> stop() async {
    await _player.stop();
    currentSound = null;
  }

  void dispose() {
    _player.dispose();
  }
}
