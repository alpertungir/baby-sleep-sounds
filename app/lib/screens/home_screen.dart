import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../providers/locale_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/mini_player_bar.dart';
import 'category_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.language,
            onPressed: () => _showLanguageMenu(context),
            icon: const Icon(Icons.language),
          ),
          IconButton(
            tooltip: l10n.refreshCatalog,
            onPressed: () => state.refreshRemoteCatalog(),
            icon: const Icon(Icons.refresh),
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
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.92,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
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
