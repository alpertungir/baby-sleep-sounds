# Keep media notification and playback service classes reachable in release
# builds where Flutter/Android enables R8 code shrinking.
-keep class com.ryanheise.audioservice.** { *; }
-keep class com.ryanheise.just_audio.** { *; }
-keep class com.ryanheise.audio_session.** { *; }
-keep class androidx.media.** { *; }
-keep class android.support.v4.media.** { *; }
