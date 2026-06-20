import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<AppState>(
      builder: (context, state, _) {
        final sound = state.currentSound;
        if (sound == null) return const SizedBox.shrink();

        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          sound.imagePath,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sound.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            StreamBuilder<Duration>(
                              stream: state.positionStream,
                              builder: (context, snapshot) {
                                final position = snapshot.data ?? Duration.zero;
                                return Text(
                                  state.isPlaying ? 'Çalıyor · ${_format(position)}' : 'Duraklatıldı',
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => state.togglePlayback(sound),
                        icon: Icon(state.isPlaying ? Icons.pause_circle : Icons.play_circle),
                        iconSize: 36,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
