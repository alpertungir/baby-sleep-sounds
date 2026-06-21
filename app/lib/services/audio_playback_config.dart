import 'package:audio_session/audio_session.dart' as audio_session;
import 'package:just_audio/just_audio.dart';

const _androidPlaybackAttributes = audio_session.AndroidAudioAttributes(
  contentType: audio_session.AndroidAudioContentType.music,
  flags: audio_session.AndroidAudioFlags.none,
  usage: audio_session.AndroidAudioUsage.media,
);

Future<void> configureAudioSessionForPlayback() async {
  final session = await audio_session.AudioSession.instance;
  await session.configure(const audio_session.AudioSessionConfiguration.music());
}

Future<void> configurePlayerForPlayback(AudioPlayer player) {
  return player.setAndroidAudioAttributes(_androidPlaybackAttributes);
}
