import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/categories.dart';
import '../l10n/app_localizations.dart';
import '../l10n/sound_l10n.dart';
import '../providers/app_state.dart';
import 'play_control_button.dart';
import 'screen_insets.dart';
import 'sleep_timer_sheet.dart';

class MiniPlayerBar extends StatelessWidget {
  const MiniPlayerBar({super.key});

  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Consumer<AppState>(
      builder: (context, state, _) {
        final sound = state.currentSound;
        if (sound == null) return const SizedBox.shrink();

        final category = categoryById(sound.categoryId);
        final accent = category?.color ?? theme.colorScheme.primary;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            12,
            0,
            12,
            ScreenInsets.miniPlayerBottom(context),
          ),
          child: Material(
            elevation: 12,
            shadowColor: accent.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(22),
            clipBehavior: Clip.antiAlias,
            color: theme.colorScheme.surface.withValues(alpha: 0.96),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent.withValues(alpha: 0.35),
                        accent,
                        theme.colorScheme.primary,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(
                            colors: [
                              accent.withValues(alpha: 0.9),
                              accent.withValues(alpha: 0.5),
                            ],
                          ),
                        ),
                        child: Icon(
                          state.isPlaying ? Icons.graphic_eq_rounded : Icons.music_note_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              sound.localizedNameOf(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            StreamBuilder<Duration>(
                              stream: state.playbackTimerStream,
                              initialData: state.playbackElapsed,
                              builder: (context, snapshot) {
                                final position = snapshot.data ?? Duration.zero;
                                return Text(
                                  state.isPlaying
                                      ? l10n.playingStatus(_format(position))
                                      : l10n.pausedStatus,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: l10n.sleepTimer,
                        onPressed: () => showSleepTimerSheet(context),
                        icon: Icon(
                          state.hasActiveTimer ? Icons.timer_rounded : Icons.timer_outlined,
                          color: state.hasActiveTimer
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface.withValues(alpha: 0.75),
                        ),
                      ),
                      if (state.hasPlaylistNavigation) ...[
                        IconButton(
                          tooltip: l10n.previousTrack,
                          onPressed: state.canSkipToPrevious
                              ? () {
                                  final previous =
                                      state.playlist[state.playlistIndex - 1];
                                  state.skipToPreviousTrack(
                                    displayTitle: previous.localizedNameOf(context),
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.skip_previous_rounded),
                        ),
                      ],
                      PlayControlButton(
                        isPlaying: state.isPlaying,
                        isLoading: false,
                        size: 44,
                        onPressed: () => state.togglePlayback(
                          sound,
                          displayTitle: sound.localizedNameOf(context),
                        ),
                      ),
                      if (state.hasPlaylistNavigation)
                        IconButton(
                          tooltip: l10n.nextTrack,
                          onPressed: state.canSkipToNext
                              ? () {
                                  final next = state.playlist[state.playlistIndex + 1];
                                  state.skipToNextTrack(
                                    displayTitle: next.localizedNameOf(context),
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.skip_next_rounded),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
