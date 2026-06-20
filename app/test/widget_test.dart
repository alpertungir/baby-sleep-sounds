import 'package:flutter_test/flutter_test.dart';
import 'package:baby_sleep_sounds/data/sound_catalog.dart';
import 'package:baby_sleep_sounds/models/sound_category.dart';

void main() {
  test('catalog has sounds for every category', () {
    for (final category in SoundCatalog.categories) {
      expect(
        SoundCatalog.soundsFor(category.id),
        isNotEmpty,
        reason: category.name,
      );
    }
  });

  test('sound ids are unique', () {
    final ids = SoundCatalog.sounds.map((sound) => sound.id).toList();
    expect(ids.length, ids.toSet().length);
  });

  test('favorite lookup works', () {
    final sound = SoundCatalog.sounds.first;
    expect(SoundCatalog.findById(sound.id), sound);
    expect(SoundCatalog.findById('missing'), isNull);
  });

  test('turkish lullaby category exists', () {
    expect(
      SoundCatalog.soundsFor(SoundCategoryId.turkishLullaby).length,
      greaterThanOrEqualTo(5),
    );
  });
}
