import 'package:flutter/material.dart';

enum SoundCategoryId {
  whiteNoise,
  lullaby,
  turkishLullaby,
  classic,
  background,
  national,
  relaxing,
}

class SoundCategory {
  const SoundCategory({
    required this.id,
    required this.icon,
    required this.imagePath,
    required this.color,
  });

  final SoundCategoryId id;
  final IconData icon;
  final String imagePath;
  final Color color;
}
