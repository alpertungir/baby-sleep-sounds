import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../l10n/category_l10n.dart';
import '../models/sound_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.soundCount,
    required this.onTap,
  });

  final SoundCategory category;
  final int soundCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                category.color,
                Color.lerp(category.color, Colors.black, 0.15)!,
              ],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            boxShadow: [
              BoxShadow(
                color: category.color.withValues(alpha: 0.28),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: _CardPatternPainter(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                Positioned(
                  right: -8,
                  bottom: -8,
                  child: Opacity(
                    opacity: 0.22,
                    child: Image.asset(
                      category.imagePath,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        category.icon,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.22),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                        ),
                        child: Icon(category.icon, color: Colors.white, size: 26),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        category.id.label(l10n),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 1.15,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.soundCount(soundCount),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.88),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardPatternPainter extends CustomPainter {
  _CardPatternPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    for (var i = 0; i < 6; i++) {
      canvas.drawCircle(
        Offset(size.width * (0.15 + i * 0.14), size.height * 0.18),
        3 + (i % 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
