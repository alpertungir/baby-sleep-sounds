import 'sound_category.dart';

class SoundItem {
  const SoundItem({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.imagePath,
    this.assetPath,
    this.storagePath,
  }) : assert(
          assetPath != null || storagePath != null,
          'Sound must have assetPath or storagePath',
        );

  final String id;
  final String name;
  final SoundCategoryId categoryId;
  final String imagePath;
  final String? assetPath;
  final String? storagePath;

  bool get isBundled => assetPath != null;
  bool get isRemote => storagePath != null;
}
