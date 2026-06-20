import '../models/sound_category.dart';
import '../models/sound_item.dart';
import 'categories.dart';
import 'sounds/lullaby_sounds.dart';
import 'sounds/turkish_lullaby_sounds.dart';
import 'sounds/white_noise_sounds.dart';

class SoundCatalog {
  static List<SoundCategory> get categories => soundCategories;

  /// Bundled in the app — updated only with a new release.
  static const bundledSounds = <SoundItem>[
    ...whiteNoiseSounds,
    ...turkishLullabySounds,
    ...lullabySounds,
  ];

  static List<SoundItem> mergeWithRemote(List<SoundItem> remoteSounds) {
    return [...bundledSounds, ...remoteSounds];
  }

  static List<SoundItem> soundsFor(
    List<SoundItem> allSounds,
    SoundCategoryId categoryId,
  ) {
    return allSounds.where((sound) => sound.categoryId == categoryId).toList();
  }

  static SoundItem? findById(List<SoundItem> allSounds, String id) {
    for (final sound in allSounds) {
      if (sound.id == id) return sound;
    }
    return null;
  }
}
