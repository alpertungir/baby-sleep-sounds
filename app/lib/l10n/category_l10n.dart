import 'package:flutter/widgets.dart';

import '../models/sound_category.dart';
import 'app_localizations.dart';

extension SoundCategoryIdL10n on SoundCategoryId {
  String label(AppLocalizations l10n) {
    return switch (this) {
      SoundCategoryId.whiteNoise => l10n.categoryWhiteNoise,
      SoundCategoryId.lullaby => l10n.categoryLullaby,
      SoundCategoryId.relaxing => l10n.categoryRelaxing,
      SoundCategoryId.music => l10n.categoryMusic,
    };
  }

  String labelOf(BuildContext context) => label(AppLocalizations.of(context)!);
}
