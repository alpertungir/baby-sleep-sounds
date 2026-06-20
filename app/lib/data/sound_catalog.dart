import '../models/sound_category.dart';
import '../models/sound_item.dart';
import 'categories.dart';
import 'sounds/background_sounds.dart';
import 'sounds/classic_sounds.dart';
import 'sounds/lullaby_sounds.dart';
import 'sounds/national_sounds.dart';
import 'sounds/relaxing_sounds.dart';
import 'sounds/turkish_lullaby_sounds.dart';
import 'sounds/white_noise_sounds.dart';

class SoundCatalog {
  static List<SoundCategory> get categories => soundCategories;

  static const sounds = <SoundItem>[
    ...whiteNoiseSounds,
    ...turkishLullabySounds,
    ...lullabySounds,
    ...classicSounds,
    ...relaxingSounds,
    ...backgroundSounds,
    ...nationalSounds,
  ];

  static List<SoundItem> soundsFor(SoundCategoryId categoryId) {
    return sounds.where((sound) => sound.categoryId == categoryId).toList();
  }

  static SoundItem? findById(String id) {
    for (final sound in sounds) {
      if (sound.id == id) return sound;
    }
    return null;
  }
}
