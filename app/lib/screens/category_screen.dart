import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/category_l10n.dart';
import '../models/sound_category.dart';
import '../providers/app_state.dart';
import '../widgets/mini_player_bar.dart';
import '../widgets/sound_tile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.category});

  final SoundCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(category.id.label(l10n))),
      body: Stack(
        children: [
          Consumer<AppState>(
            builder: (context, state, _) {
              final sounds = state.soundsFor(category.id);

              if (sounds.isEmpty) {
                return Center(child: Text(l10n.emptyCategory));
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 96),
                itemCount: sounds.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
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
                          SnackBar(content: Text(l10n.downloadFailed('$error'))),
                        );
                      }
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
