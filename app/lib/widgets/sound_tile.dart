import 'package:flutter/material.dart';

import '../data/categories.dart';
import '../l10n/app_localizations.dart';
import '../l10n/sound_l10n.dart';
import '../models/sound_item.dart';
import 'play_control_button.dart';

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
    final category = categoryById(sound.categoryId);
    final accent = category?.color ?? theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Material(
        color: isPlaying
            ? accent.withValues(alpha: 0.22)
            : theme.colorScheme.surface.withValues(alpha: 0.65),
        elevation: isPlaying ? 3 : 0,
        shadowColor: accent.withValues(alpha: 0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: isPlaying
                ? accent.withValues(alpha: 0.55)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: isLoading ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [
                        accent.withValues(alpha: 0.85),
                        accent.withValues(alpha: 0.45),
                      ],
                    ),
                  ),
                  child: Icon(
                    isPlaying ? Icons.graphic_eq_rounded : Icons.music_note_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sound.localizedNameOf(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: isPlaying ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                      if (sound.isRemote && !isCached)
                        Text(
                          l10n.downloadOnFirstPlay,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.tertiary.withValues(alpha: 0.9),
                          ),
                        ),
                    ],
                  ),
                ),
                if (sound.isRemote && !isCached)
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.cloud_download_outlined,
                      color: theme.colorScheme.tertiary,
                      size: 20,
                    ),
                  ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: onFavoriteTap,
                  icon: Icon(
                    isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: isFavorite ? Colors.pinkAccent : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    size: 22,
                  ),
                ),
                PlayControlButton(
                  isPlaying: isPlaying,
                  isLoading: isLoading,
                  onPressed: onTap,
                  size: 44,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
