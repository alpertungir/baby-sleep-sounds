import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sound_category.dart';
import '../providers/app_state.dart';
import '../widgets/mini_player_bar.dart';
import '../widgets/sound_tile.dart';
import 'player_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.category});

  final SoundCategory category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Stack(
        children: [
          Consumer<AppState>(
            builder: (context, state, _) {
              final sounds = state.soundsFor(category.id);

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                itemCount: sounds.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final sound = sounds[index];
                  final isPlaying =
                      state.currentSound?.id == sound.id && state.isPlaying;

                  return SoundTile(
                    sound: sound,
                    isFavorite: state.isFavorite(sound.id),
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
