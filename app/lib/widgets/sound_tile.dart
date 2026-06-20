import 'package:flutter/material.dart';

import '../models/sound_item.dart';

class SoundTile extends StatelessWidget {
  const SoundTile({
    super.key,
    required this.sound,
    required this.isFavorite,
    required this.isPlaying,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final SoundItem sound;
  final bool isFavorite;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            sound.imagePath,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 52,
              height: 52,
              color: theme.colorScheme.primaryContainer,
              child: Icon(Icons.music_note, color: theme.colorScheme.primary),
            ),
          ),
        ),
        title: Text(
          sound.name,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onFavoriteTap,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.pinkAccent : null,
              ),
            ),
            CircleAvatar(
              backgroundColor: isPlaying
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceContainerHighest,
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: isPlaying ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
