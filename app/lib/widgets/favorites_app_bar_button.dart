import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../screens/favorites_screen.dart';

class FavoritesAppBarButton extends StatelessWidget {
  const FavoritesAppBarButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      tooltip: l10n.favorites,
      onPressed: () => openFavoritesScreen(context),
      icon: Icon(Icons.favorite_outline, color: color),
    );
  }
}
