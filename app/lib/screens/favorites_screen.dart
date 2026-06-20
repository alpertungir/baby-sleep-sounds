import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/mini_player_bar.dart';
import '../widgets/sound_tile.dart';
import 'player_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoriler')),
      body: Stack(
        children: [
          Consumer<AppState>(
            builder: (context, state, _) {
              final favorites = state.favoriteSounds;

              if (favorites.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 56,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz favori ses yok',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ses listesindeki kalp simgesine dokunarak favorilere ekleyebilirsin.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                itemCount: favorites.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final sound = favorites[index];
                  final isPlaying =
                      state.currentSound?.id == sound.id && state.isPlaying;

                  return SoundTile(
                    sound: sound,
                    isFavorite: true,
                    isPlaying: isPlaying,
                    isLoading: state.isLoading(sound),
                    isCached: state.isCached(sound),
                    onFavoriteTap: () => state.toggleFavorite(sound.id),
                    onTap: () async {
                      try {
                        await state.playSound(sound);
                      } catch (error) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Ses indirilemedi: $error')),
                        );
                        return;
                      }
                      if (!context.mounted) return;
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PlayerScreen(sound: sound),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: MiniPlayerBar(),
          ),
        ],
      ),
    );
  }
}
