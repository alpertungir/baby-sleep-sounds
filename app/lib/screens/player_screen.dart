import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/sound_item.dart';
import '../providers/app_state.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, required this.sound});

  final SoundItem sound;

  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _showTimerSheet(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final state = context.read<AppState>();
    final options = <Duration?>[
      const Duration(minutes: 15),
      const Duration(minutes: 30),
      const Duration(minutes: 45),
      const Duration(minutes: 60),
      const Duration(minutes: 120),
      null,
    ];

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(l10n.sleepTimer, style: Theme.of(context).textTheme.titleMedium),
                ),
                ...options.map((duration) {
                  final label = duration == null
                      ? l10n.unlimited
                      : l10n.minutesOption(duration.inMinutes);
                  return ListTile(
                    title: Text(label),
                    onTap: () {
                      if (duration == null) {
                        state.cancelSleepTimer();
                      } else {
                        state.startSleepTimer(duration);
                      }
                      Navigator.pop(context);
                    },
                  );
                }),
                if (state.hasActiveTimer)
                  ListTile(
                    title: Text(l10n.cancelTimer),
                    onTap: () {
                      state.cancelSleepTimer();
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<AppState>(
      builder: (context, state, _) {
        final isCurrent = state.currentSound?.id == sound.id;
        final playing = isCurrent && state.isPlaying;

        return Scaffold(
          appBar: AppBar(
            title: Text(sound.name),
            actions: [
              IconButton(
                onPressed: () => state.toggleFavorite(sound.id),
                icon: Icon(
                  state.isFavorite(sound.id) ? Icons.favorite : Icons.favorite_border,
                  color: state.isFavorite(sound.id) ? Colors.pinkAccent : null,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                Icon(Icons.music_note, size: 72, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 24),
                Text(sound.name, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.volume_down),
                    Expanded(
                      child: Slider(
                        value: state.volume,
                        onChanged: (value) => state.setVolume(value),
                      ),
                    ),
                    const Icon(Icons.volume_up),
                  ],
                ),
                if (state.hasActiveTimer)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(l10n.timerRemaining(_format(state.timerRemaining!))),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _showTimerSheet(context),
                      icon: const Icon(Icons.timer_outlined),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {
                        if (playing) {
                          state.pause();
                        } else {
                          state.playSound(sound);
                        }
                      },
                      icon: Icon(
                        playing ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () => state.toggleFavorite(sound.id),
                      icon: Icon(
                        state.isFavorite(sound.id) ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
