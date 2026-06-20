import 'sound_category.dart';

class SoundItem {
  const SoundItem({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.audioPath,
    required this.imagePath,
  });

  final String id;
  final String name;
  final SoundCategoryId categoryId;
  final String audioPath;
  final String imagePath;
}
