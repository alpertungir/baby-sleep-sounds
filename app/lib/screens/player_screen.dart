import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sound_item.dart';
import '../providers/app_state.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, required this.sound});

  final SoundItem sound;

  String _format(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  Future<void> _showTimerSheet(BuildContext context) async {
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Uyku Zamanlayıcısı',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ...options.map((duration) {
                  final label = duration == null
                      ? 'Sınırsız'
                      : '${duration.inMinutes} dakika';
                  return ListTile(
                    leading: Icon(
                      duration == null ? Icons.all_inclusive : Icons.timer_outlined,
                    ),
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
                  FilledButton.tonal(
                    onPressed: () {
                      state.cancelSleepTimer();
                      Navigator.pop(context);
                    },
                    child: const Text('Zamanlayıcıyı İptal Et'),
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
    final theme = Theme.of(context);

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
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          sound.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: theme.colorScheme.primaryContainer,
                            child: Icon(
                              Icons.music_note,
                              size: 72,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                StreamBuilder<Duration>(
                  stream: state.positionStream,
                  builder: (context, positionSnapshot) {
                    return StreamBuilder<Duration?>(
                      stream: state.durationStream,
                      builder: (context, durationSnapshot) {
                        final position = isCurrent
                            ? (positionSnapshot.data ?? Duration.zero)
                            : Duration.zero;
                        final total = isCurrent
                            ? (durationSnapshot.data ?? Duration.zero)
                            : Duration.zero;

                        return Column(
                          children: [
                            Slider(
                              value: total.inMilliseconds == 0
                                  ? 0
                                  : position.inMilliseconds
                                      .clamp(0, total.inMilliseconds)
                                      .toDouble(),
                              max: total.inMilliseconds == 0
                                  ? 1
                                  : total.inMilliseconds.toDouble(),
                              onChanged: null,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_format(position)),
                                Text(_format(total)),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 8),
                if (state.hasActiveTimer)
                  Chip(
                    avatar: const Icon(Icons.timer, size: 18),
                    label: Text('Kalan: ${_format(state.timerRemaining!)}'),
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () => _showTimerSheet(context),
                      iconSize: 28,
                      icon: const Icon(Icons.timer_outlined),
                    ),
                    const SizedBox(width: 24),
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
                    const SizedBox(width: 24),
                    IconButton.filledTonal(
                      onPressed: () => state.toggleFavorite(sound.id),
                      iconSize: 28,
                      icon: Icon(
                        state.isFavorite(sound.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
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
