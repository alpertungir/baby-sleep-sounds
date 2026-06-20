import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../providers/locale_provider.dart';
import '../widgets/app_info_footer.dart';
import '../widgets/category_card.dart';
import '../widgets/decorative_background.dart';
import '../widgets/home_header.dart';
import '../widgets/mini_player_bar.dart';
import '../widgets/screen_insets.dart';
import 'category_screen.dart';
import 'favorites_screen.dart';

enum _HomeMenuAction { refreshCatalog }

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

  void _showLanguageMenu(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = context.read<LocaleProvider>();

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(l10n.systemLanguage),
                trailing: localeProvider.usesSystemLocale ? const Icon(Icons.check) : null,
                onTap: () {
                  localeProvider.useSystemLocale();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(l10n.turkish),
                trailing: localeProvider.locale?.languageCode == 'tr'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  localeProvider.setLocale(const Locale('tr'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(l10n.english),
                trailing: localeProvider.locale?.languageCode == 'en'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  localeProvider.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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
                  IconButton(
                    tooltip: l10n.language,
                    onPressed: () => _showLanguageMenu(context),
                    icon: const Icon(Icons.language),
                  ),
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
                      if (action == _HomeMenuAction.refreshCatalog) {
                        state.refreshRemoteCatalog();
                      }
                    },
                    itemBuilder: (context) => [
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
              const SliverToBoxAdapter(child: AppInfoFooter()),
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
