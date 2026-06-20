import 'package:flutter_test/flutter_test.dart';
import 'package:baby_sleep_sounds/models/sound_category.dart';
import 'package:baby_sleep_sounds/data/sound_catalog.dart';
import 'package:baby_sleep_sounds/models/sound_category.dart';

void main() {
  test('bundled sounds exist for offline categories', () {
    for (final categoryId in [
      SoundCategoryId.whiteNoise,
      SoundCategoryId.turkishLullaby,
      SoundCategoryId.lullaby,
    ]) {
      expect(
        SoundCatalog.soundsFor(SoundCatalog.bundledSounds, categoryId),
        isNotEmpty,
        reason: categoryId.name,
      );
    }
  });

  test('bundled sound ids are unique', () {
    final ids = SoundCatalog.bundledSounds.map((sound) => sound.id).toList();
    expect(ids.length, ids.toSet().length);
  });

  test('favorite lookup works', () {
    final sound = SoundCatalog.bundledSounds.first;
    expect(SoundCatalog.findById(SoundCatalog.bundledSounds, sound.id), sound);
    expect(SoundCatalog.findById(SoundCatalog.bundledSounds, 'missing'), isNull);
  });

  test('turkish lullaby category exists', () {
    expect(
      SoundCatalog.soundsFor(
        SoundCatalog.bundledSounds,
        SoundCategoryId.turkishLullaby,
      ).length,
      greaterThanOrEqualTo(5),
    );
  });
}
