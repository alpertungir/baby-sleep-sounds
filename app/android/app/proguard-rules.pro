# Keep the native media service classes referenced from AndroidManifest.xml and
# audio_service callbacks stable when release builds are code-shrunk.
-keep class com.ryanheise.audioservice.** { *; }
-keep class com.ryanheise.just_audio.** { *; }
-keep class com.ryanheise.audio_session.** { *; }
-keep class androidx.media.** { *; }
-keep class android.support.v4.media.** { *; }

# just_audio uses ExoPlayer/Media3 on Android; keep public members available for
# foreground media notification and media session integrations.
-keep class androidx.media3.** { *; }
-keep class com.google.android.exoplayer2.** { *; }
