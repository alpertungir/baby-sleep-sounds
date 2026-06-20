import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/sound_item.dart';
import '../providers/app_state.dart';
import '../widgets/sleep_timer_sheet.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, required this.sound});

  final SoundItem sound;

  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
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
                onPressed: () => showSleepTimerSheet(context),
                icon: const Icon(Icons.timer_outlined),
              ),
              IconButton(
                onPressed: () => state.toggleFavorite(sound.id),
                icon: Icon(
                  state.isFavorite(sound.id) ? Icons.favorite : Icons.favorite_border,
                  color: state.isFavorite(sound.id) ? Colors.pinkAccent : null,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.nights_stay_rounded,
                            size: 88,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            sound.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          if (state.hasActiveTimer) ...[
                            const SizedBox(height: 16),
                            Chip(
                              avatar: const Icon(Icons.timer, size: 18),
                              label: Text(l10n.timerRemaining(_format(state.timerRemaining!))),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: () => showSleepTimerSheet(context),
                        icon: const Icon(Icons.timer_outlined),
                        label: Text(l10n.sleepTimer),
                      ),
                      FilledButton(
                        onPressed: () {
                          if (playing) {
                            state.pause();
                          } else {
                            state.playSound(sound);
                          }
                        },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          shape: const CircleBorder(),
                        ),
                        child: Icon(
                          playing ? Icons.pause : Icons.play_arrow,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
