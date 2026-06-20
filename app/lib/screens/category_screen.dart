import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/category_l10n.dart';
import '../models/sound_category.dart';
import '../providers/app_state.dart';
import '../widgets/category_header.dart';
import '../widgets/decorative_background.dart';
import '../widgets/mini_player_bar.dart';
import '../widgets/screen_insets.dart';
import '../widgets/sleep_timer_sheet.dart';
import '../widgets/sound_tile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.category});

  final SoundCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: DecorativeBackground()),
          Consumer<AppState>(
            builder: (context, state, _) {
              final sounds = state.soundsFor(category.id);
              final bottomInset = ScreenInsets.listBottom(context, state);

              if (sounds.isEmpty) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: category.color,
                      foregroundColor: Colors.white,
                      title: Text(category.id.label(l10n)),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          l10n.emptyCategory,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 148,
                    pinned: true,
                    stretch: true,
                    backgroundColor: category.color,
                    foregroundColor: Colors.white,
                    title: Text(category.id.label(l10n)),
                    actions: [
                      IconButton(
                        tooltip: l10n.sleepTimer,
                        onPressed: () => showSleepTimerSheet(context),
                        icon: const Icon(Icons.timer_outlined),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: CategoryHeader(
                        category: category,
                        soundCount: sounds.length,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 8, bottom: bottomInset),
                    sliver: SliverList.builder(
                      itemCount: sounds.length,
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
                    ),
                  ),
                ],
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
