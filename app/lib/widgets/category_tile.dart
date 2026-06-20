import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../l10n/category_l10n.dart';
import '../models/sound_category.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.soundCount,
    required this.onTap,
  });

  final SoundCategory category;
  final int soundCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: Icon(category.icon, color: category.color),
      title: Text(category.id.label(l10n)),
      subtitle: Text(l10n.soundCount(soundCount)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
