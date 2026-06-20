import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Soft star/moon pattern for empty areas on home and category screens.
class DecorativeBackground extends StatelessWidget {
  const DecorativeBackground({super.key, this.accent});

  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final tint = accent ?? Theme.of(context).colorScheme.onSurface;

    return CustomPaint(
      painter: _SleepPatternPainter(tint.withValues(alpha: 0.07)),
      child: const SizedBox.expand(),
    );
  }
}

class _SleepPatternPainter extends CustomPainter {
  _SleepPatternPainter(this.color);

  final Color color;

  static final _stars = _buildStars();

  static List<_Star> _buildStars() {
    final random = math.Random(42);
    return List.generate(28, (index) {
      return _Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        radius: 1.2 + random.nextDouble() * 2.4,
        opacity: 0.35 + random.nextDouble() * 0.65,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    for (final star in _stars) {
      paint.color = color.withValues(alpha: star.opacity);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.radius,
        paint,
      );
    }

    paint.color = color.withValues(alpha: 0.5);
    _drawMoon(canvas, Offset(size.width * 0.88, size.height * 0.12), 18);
    _drawMoon(canvas, Offset(size.width * 0.1, size.height * 0.78), 12);
  }

  void _drawMoon(Canvas canvas, Offset center, double radius) {
    final paint = Paint()..color = color.withValues(alpha: 0.45);
    canvas.drawCircle(center, radius, paint);
    paint.color = const Color(0xFF2D1B69).withValues(alpha: 0.85);
    canvas.drawCircle(center + Offset(radius * 0.35, -radius * 0.15), radius * 0.82, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Star {
  const _Star({
    required this.x,
    required this.y,
    required this.radius,
    required this.opacity,
  });

  final double x;
  final double y;
  final double radius;
  final double opacity;
}
