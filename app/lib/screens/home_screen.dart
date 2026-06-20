import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../widgets/category_card.dart';
import '../widgets/decorative_background.dart';
import '../widgets/home_header.dart';
import '../widgets/language_menu_button.dart';
import '../widgets/mini_player_bar.dart';
import '../widgets/screen_insets.dart';
import 'category_screen.dart';
import 'favorites_screen.dart';
import 'support_screen.dart';

enum _HomeMenuAction { refreshCatalog, support }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _horizontalPadding = 16.0;
  static const _gridSpacing = 14.0;
  static const _targetAspectRatio = 1.0;

  int _crossAxisCount(double width) {
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = context.watch<AppState>();
    final categories = state.visibleCategories;
    final totalSounds = categories.fold<int>(
      0,
      (sum, category) => sum + state.soundsFor(category.id).length,
    );
    final contentWidth = MediaQuery.sizeOf(context).width - (_horizontalPadding * 2);
    final crossAxisCount = _crossAxisCount(contentWidth);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: DecorativeBackground()),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 152,
                pinned: true,
                stretch: true,
                automaticallyImplyLeading: false,
                leading: const SizedBox.shrink(),
                leadingWidth: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Colors.white,
                title: Text(l10n.appTitle),
                actions: [
                  const LanguageMenuButton(),
                  IconButton(
                    tooltip: l10n.favorites,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                      );
                    },
                    icon: const Icon(Icons.favorite_outline),
                  ),
                  PopupMenuButton<_HomeMenuAction>(
                    tooltip: l10n.refreshCatalog,
                    onSelected: (action) {
                      switch (action) {
                        case _HomeMenuAction.refreshCatalog:
                          state.refreshRemoteCatalog();
                        case _HomeMenuAction.support:
                          openSupportScreen(context);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: _HomeMenuAction.support,
                        child: ListTile(
                          leading: const Icon(Icons.volunteer_activism_outlined),
                          title: Text(l10n.supportMenu),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                      PopupMenuItem(
                        value: _HomeMenuAction.refreshCatalog,
                        child: ListTile(
                          leading: const Icon(Icons.sync),
                          title: Text(l10n.refreshCatalog),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                    ],
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: HomeHeader(totalSounds: totalSounds),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  _horizontalPadding,
                  8,
                  _horizontalPadding,
                  ScreenInsets.listBottom(context, state),
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: _gridSpacing,
                    mainAxisSpacing: _gridSpacing,
                    childAspectRatio: _targetAspectRatio,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = categories[index];
                      final count = state.soundsFor(category.id).length;

                      return CategoryCard(
                        category: category,
                        soundCount: count,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoryScreen(category: category),
                            ),
                          );
                        },
                      );
                    },
                    childCount: categories.length,
                  ),
                ),
              ),
            ],
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
