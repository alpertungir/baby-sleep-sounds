import 'package:flutter/material.dart';

import '../models/sound_category.dart';

const soundCategories = <SoundCategory>[
  SoundCategory(
    id: SoundCategoryId.whiteNoise,
    icon: Icons.air,
    imagePath: 'assets/images/app/whitenoise-music.png',
    color: Color(0xFF42A5F5),
  ),
  SoundCategory(
    id: SoundCategoryId.lullaby,
    icon: Icons.nightlight_round,
    imagePath: 'assets/images/app/lullaby-music.png',
    color: Color(0xFFAB47BC),
  ),
  SoundCategory(
    id: SoundCategoryId.relaxing,
    icon: Icons.spa_outlined,
    imagePath: 'assets/images/app/relaxing-music.png',
    color: Color(0xFF66BB6A),
  ),
  SoundCategory(
    id: SoundCategoryId.music,
    icon: Icons.music_note_outlined,
    imagePath: 'assets/images/app/background-music.png',
    color: Color(0xFFFFA726),
  ),
];

SoundCategory? categoryById(SoundCategoryId id) {
  for (final category in soundCategories) {
    if (category.id == id) return category;
  }
  return null;
}
