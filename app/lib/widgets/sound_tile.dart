import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/sound_item.dart';

class SoundTile extends StatelessWidget {
  const SoundTile({
    super.key,
    required this.sound,
    required this.isFavorite,
    required this.isPlaying,
    required this.isLoading,
    required this.isCached,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final SoundItem sound;
  final bool isFavorite;
  final bool isPlaying;
  final bool isLoading;
  final bool isCached;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ListTile(
      title: Text(sound.name),
      subtitle: sound.isRemote && !isCached ? Text(l10n.downloadOnFirstPlay) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (sound.isRemote && !isCached)
            Icon(Icons.cloud_download_outlined, color: theme.colorScheme.primary, size: 20),
          IconButton(
            onPressed: onFavoriteTap,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.pinkAccent : null,
            ),
          ),
          IconButton(
            onPressed: isLoading ? null : onTap,
            icon: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.primary),
                  )
                : Icon(
                    isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    size: 32,
                    color: theme.colorScheme.primary,
                  ),
          ),
        ],
      ),
      onTap: isLoading ? null : onTap,
    );
  }
}
