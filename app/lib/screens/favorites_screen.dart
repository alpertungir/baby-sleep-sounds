import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/sound_l10n.dart';
import '../providers/app_state.dart';
import '../widgets/language_menu_button.dart';
import '../widgets/mini_player_bar.dart';
import '../widgets/screen_insets.dart';
import '../widgets/sound_tile.dart';

void openFavoritesScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const FavoritesScreen()),
  );
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favorites),
        actions: const [LanguageMenuButton()],
      ),
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
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(l10n.favoritesEmptyTitle),
                        const SizedBox(height: 8),
                        Text(
                          l10n.favoritesEmptyBody,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: ScreenInsets.listBottom(context, state),
                ),
                itemCount: favorites.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            l10n.playlistHint,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                          ),
                          const SizedBox(height: 10),
                          FilledButton.icon(
                            onPressed: () => state.playPlaylist(favorites),
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: Text(l10n.playAll),
                          ),
                        ],
                      ),
                    );
                  }

                  final sound = favorites[index - 1];
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
                        await state.playSound(
                          sound,
                          displayTitle: sound.localizedNameOf(context),
                          playlist: favorites,
                        );
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
