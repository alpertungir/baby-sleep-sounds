import 'package:flutter/material.dart';

/// Large, easy-to-tap play/pause control for sound lists and mini player.
class PlayControlButton extends StatelessWidget {
  const PlayControlButton({
    super.key,
    required this.isPlaying,
    required this.isLoading,
    required this.onPressed,
    this.size = 48,
  });

  final bool isPlaying;
  final bool isLoading;
  final VoidCallback? onPressed;
  final double size;

  static const double _minTapTarget = 48;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tapExtent = size < _minTapTarget ? _minTapTarget : size + 8;

    return Semantics(
      button: true,
      label: isPlaying ? 'Pause' : 'Play',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: isLoading ? null : onPressed,
          child: SizedBox(
            width: tapExtent,
            height: tapExtent,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isPlaying
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            scheme.primary,
                            Color.lerp(scheme.primary, scheme.tertiary, 0.35)!,
                          ],
                        )
                      : null,
                  color: isPlaying ? null : scheme.onSurface.withValues(alpha: 0.1),
                  border: isPlaying
                      ? null
                      : Border.all(
                          color: scheme.primary.withValues(alpha: 0.55),
                          width: 1.5,
                        ),
                  boxShadow: isPlaying
                      ? [
                          BoxShadow(
                            color: scheme.primary.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: SizedBox(
                  width: size,
                  height: size,
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: size * 0.5,
                            height: size * 0.5,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: scheme.primary,
                            ),
                          )
                        : Icon(
                            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            size: size * 0.58,
                            color: isPlaying ? scheme.onPrimary : scheme.primary,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
