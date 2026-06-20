import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/sound_display_names.dart';
import '../models/sound_item.dart';
import '../providers/locale_provider.dart';

extension SoundItemL10n on SoundItem {
  String localizedNameOf(BuildContext context) {
    final locale = context.read<LocaleProvider>().effectiveLocale;
    return soundDisplayNames[id]?.forLocale(locale) ?? name;
  }
}
