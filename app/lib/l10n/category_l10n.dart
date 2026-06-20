import 'package:flutter/widgets.dart';

import '../models/sound_category.dart';
import 'app_localizations.dart';

extension SoundCategoryIdL10n on SoundCategoryId {
  String label(AppLocalizations l10n) {
    return switch (this) {
      SoundCategoryId.whiteNoise => l10n.categoryWhiteNoise,
      SoundCategoryId.turkishLullaby => l10n.categoryTurkishLullaby,
      SoundCategoryId.lullaby => l10n.categoryLullaby,
      SoundCategoryId.classic => l10n.categoryClassic,
      SoundCategoryId.relaxing => l10n.categoryRelaxing,
      SoundCategoryId.background => l10n.categoryBackground,
      SoundCategoryId.national => l10n.categoryNational,
    };
  }

  String labelOf(BuildContext context) => label(AppLocalizations.of(context)!);
}
