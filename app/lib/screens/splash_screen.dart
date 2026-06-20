import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/decorative_background.dart';
import '../widgets/package_info_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _pulseController;
  late final Animation<double> _fadeIn;
  late final Animation<double> _moonScale;
  late final Animation<double> _titleFade;
  late final Animation<double> _exitFade;

  @override
  void initState() {
    super.initState();
    PackageInfoLoader.instance.load();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _fadeIn = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );
    _moonScale = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.1, 0.55, curve: Curves.elasticOut),
    );
    _titleFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
    );
    _exitFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.78, 1.0, curve: Curves.easeIn),
    );

    _mainController.forward().whenComplete(() {
      if (mounted) widget.onFinished();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: Listenable.merge([_mainController, _pulseController]),
      builder: (context, _) {
        final exitOpacity = 1 - _exitFade.value;

        return Opacity(
          opacity: exitOpacity,
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: Stack(
              children: [
                Opacity(
                  opacity: _fadeIn.value,
                  child: const DecorativeBackground(accent: Colors.white),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const Spacer(flex: 3),
                        Transform.translate(
                          offset: Offset(0, -10 * math.sin(_pulseController.value * math.pi)),
                          child: Transform.scale(
                            scale: 0.7 + (_moonScale.value * 0.3),
                            child: _AnimatedMoonGlow(
                              glow: 0.45 + (_pulseController.value * 0.25),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Opacity(
                          opacity: _titleFade.value,
                          child: Column(
                            children: [
                              Text(
                                l10n.appTitle,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _SleepPulseBar(progress: _pulseController.value),
                            ],
                          ),
                        ),
                        const Spacer(flex: 2),
                        Opacity(
                          opacity: _titleFade.value,
                          child: FutureBuilder<PackageInfoData>(
                            future: PackageInfoLoader.instance.load(),
                            builder: (context, snapshot) {
                              final version = snapshot.data?.version ?? '…';
                              final caption = theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              );

                              return Column(
                                children: [
                                  Text(l10n.developedBy, style: caption),
                                  const SizedBox(height: 2),
                                  Text(l10n.versionLabel(version), style: caption),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedMoonGlow extends StatelessWidget {
  const _AnimatedMoonGlow({required this.glow});

  final double glow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 140 + (glow * 24),
          height: 140 + (glow * 24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.25 + glow * 0.2),
                blurRadius: 36,
                spreadRadius: 8,
              ),
            ],
          ),
        ),
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFFFFE082),
                theme.colorScheme.primary,
                const Color(0xFFFF8F00).withValues(alpha: 0.85),
              ],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 2),
          ),
          child: const Icon(Icons.nightlight_round, size: 58, color: Colors.white),
        ),
      ],
    );
  }
}

class _SleepPulseBar extends StatelessWidget {
  const _SleepPulseBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 120,
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: LinearProgressIndicator(
          value: 0.25 + (progress * 0.75),
          backgroundColor: Colors.white.withValues(alpha: 0.12),
          color: theme.colorScheme.primary.withValues(alpha: 0.85),
          minHeight: 4,
        ),
      ),
    );
  }
}
