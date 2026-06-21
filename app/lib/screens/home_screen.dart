import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../services/remote_catalog_service.dart';
import '../widgets/category_card.dart';
import '../widgets/decorative_background.dart';
import '../widgets/favorites_app_bar_button.dart';
import '../widgets/home_header.dart';
import '../widgets/home_support_footer.dart';
import '../widgets/language_menu_button.dart';
import '../widgets/mini_player_bar.dart';
import '../widgets/screen_insets.dart';
import 'category_screen.dart';
import 'favorites_screen.dart';
import 'support_screen.dart';

enum _HomeMenuAction { favorites, refreshCatalog, support }

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
                  const FavoritesAppBarButton(),
                  PopupMenuButton<_HomeMenuAction>(
                    tooltip: l10n.refreshCatalog,
                    icon: state.isRefreshingCatalog
                        ? SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          )
                        : null,
                    onSelected: (action) async {
                      switch (action) {
                        case _HomeMenuAction.favorites:
                          openFavoritesScreen(context);
                        case _HomeMenuAction.refreshCatalog:
                          await _refreshCatalog(context, state);
                        case _HomeMenuAction.support:
                          openSupportScreen(context);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: _HomeMenuAction.favorites,
                        child: ListTile(
                          leading: const Icon(Icons.queue_music_outlined),
                          title: Text(l10n.playlist),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
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
                        enabled: !state.isRefreshingCatalog,
                        child: ListTile(
                          leading: state.isRefreshingCatalog
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.sync),
                          title: Text(
                            state.isRefreshingCatalog
                                ? l10n.refreshCatalogInProgress
                                : l10n.refreshCatalog,
                          ),
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
                  ScreenInsets.listBottom(context, state, includeSupportFooter: true),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: state.currentSound == null
                ? const HomeSupportFooter()
                : const MiniPlayerBar(),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshCatalog(BuildContext context, AppState state) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(l10n.refreshCatalogInProgress)),
          ],
        ),
        duration: const Duration(days: 1),
      ),
    );

    final result = await state.refreshRemoteCatalog();
    messenger.hideCurrentSnackBar();
    if (!context.mounted || result == null) return;

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(_catalogRefreshMessage(l10n, result)),
      ),
    );
  }

  String _catalogRefreshMessage(AppLocalizations l10n, CatalogRefreshResult result) {
    return switch (result.source) {
      CatalogSource.remote when result.hasChanges =>
        l10n.refreshCatalogUpdated(result.newCount),
      CatalogSource.remote => l10n.refreshCatalogUpToDate,
      CatalogSource.cache => l10n.refreshCatalogUsedCache(result.newCount),
      CatalogSource.fallback => l10n.refreshCatalogOffline(result.newCount),
    };
  }
}
