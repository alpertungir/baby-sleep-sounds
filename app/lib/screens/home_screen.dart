import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/category_card.dart';
import '../widgets/mini_player_bar.dart';
import 'category_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bebek Uyku Sesleri'),
        actions: [
          IconButton(
            tooltip: 'Favoriler',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
            icon: Badge(
              isLabelVisible: state.favoriteSounds.isNotEmpty,
              label: Text('${state.favoriteSounds.length}'),
              child: const Icon(Icons.favorite_outline),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
            children: [
              Text(
                'Sakin bir gece için ses seç',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kategorilere dokun, sesi başlat ve uyku zamanlayıcısını ayarla.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
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
