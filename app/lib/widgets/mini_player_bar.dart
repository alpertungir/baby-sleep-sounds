import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../screens/player_screen.dart';

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

    return Consumer<AppState>(
      builder: (context, state, _) {
        final sound = state.currentSound;
        if (sound == null) return const SizedBox.shrink();

        return SafeArea(
          top: false,
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PlayerScreen(sound: sound),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sound.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          StreamBuilder<Duration>(
                            stream: state.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;
                              return Text(
                                state.isPlaying
                                    ? l10n.playingStatus(_format(position))
                                    : l10n.pausedStatus,
                                style: Theme.of(context).textTheme.bodySmall,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => state.togglePlayback(sound),
                      icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
