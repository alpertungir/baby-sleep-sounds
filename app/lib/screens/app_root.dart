import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'splash_screen.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  var _showHome = false;

  @override
  Widget build(BuildContext context) {
    if (_showHome) return const HomeScreen();

    return SplashScreen(
      onFinished: () {
        if (!mounted) return;
        setState(() => _showHome = true);
      },
    );
  }
}
