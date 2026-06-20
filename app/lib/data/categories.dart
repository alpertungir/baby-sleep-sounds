import 'package:flutter/material.dart';

import '../models/sound_category.dart';

const soundCategories = <SoundCategory>[
  SoundCategory(
    id: SoundCategoryId.whiteNoise,
    name: 'Beyaz Gürültü',
    icon: Icons.air,
    imagePath: 'assets/images/app/whitenoise-music.png',
    color: Color(0xFF5B7FA6),
  ),
  SoundCategory(
    id: SoundCategoryId.turkishLullaby,
    name: 'Türk Ninneleri',
    icon: Icons.flag_outlined,
    imagePath: 'assets/images/app/national-music.png',
    color: Color(0xFFB86B6B),
  ),
  SoundCategory(
    id: SoundCategoryId.lullaby,
    name: 'Ninni',
    icon: Icons.nightlight_round,
    imagePath: 'assets/images/app/lullaby-music.png',
    color: Color(0xFF8B6BA8),
  ),
  SoundCategory(
    id: SoundCategoryId.classic,
    name: 'Klasik',
    icon: Icons.music_note_outlined,
    imagePath: 'assets/images/app/classic-music.png',
    color: Color(0xFF9C8AA5),
  ),
  SoundCategory(
    id: SoundCategoryId.relaxing,
    name: 'Rahatlatıcı',
    icon: Icons.spa_outlined,
    imagePath: 'assets/images/app/relaxing-music.png',
    color: Color(0xFF6B9E7A),
  ),
  SoundCategory(
    id: SoundCategoryId.background,
    name: 'Arka Plan',
    icon: Icons.queue_music_outlined,
    imagePath: 'assets/images/app/background-music.png',
    color: Color(0xFF7A8F6E),
  ),
  SoundCategory(
    id: SoundCategoryId.national,
    name: 'Dünya Ninneleri',
    icon: Icons.public,
    imagePath: 'assets/images/app/national-music.png',
    color: Color(0xFF6B84A8),
  ),
];

SoundCategory? categoryById(SoundCategoryId id) {
  for (final category in soundCategories) {
    if (category.id == id) return category;
  }
  return null;
}
