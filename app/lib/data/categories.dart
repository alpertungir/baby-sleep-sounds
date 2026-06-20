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
    id: SoundCategoryId.turkishLullaby,
    icon: Icons.flag_outlined,
    imagePath: 'assets/images/app/national-music.png',
    color: Color(0xFFEF5350),
  ),
  SoundCategory(
    id: SoundCategoryId.lullaby,
    icon: Icons.nightlight_round,
    imagePath: 'assets/images/app/lullaby-music.png',
    color: Color(0xFFAB47BC),
  ),
  SoundCategory(
    id: SoundCategoryId.classic,
    icon: Icons.music_note_outlined,
    imagePath: 'assets/images/app/classic-music.png',
    color: Color(0xFF7E57C2),
  ),
  SoundCategory(
    id: SoundCategoryId.relaxing,
    icon: Icons.spa_outlined,
    imagePath: 'assets/images/app/relaxing-music.png',
    color: Color(0xFF66BB6A),
  ),
  SoundCategory(
    id: SoundCategoryId.background,
    icon: Icons.queue_music_outlined,
    imagePath: 'assets/images/app/background-music.png',
    color: Color(0xFFFFA726),
  ),
  SoundCategory(
    id: SoundCategoryId.national,
    icon: Icons.public,
    imagePath: 'assets/images/app/national-music.png',
    color: Color(0xFF26C6DA),
  ),
];

SoundCategory? categoryById(SoundCategoryId id) {
  for (final category in soundCategories) {
    if (category.id == id) return category;
  }
  return null;
}
