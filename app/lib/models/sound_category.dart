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
    required this.name,
    required this.icon,
    required this.imagePath,
    required this.color,
  });

  final SoundCategoryId id;
  final String name;
  final IconData icon;
  final String imagePath;
  final Color color;
}
