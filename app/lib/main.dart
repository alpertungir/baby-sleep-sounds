import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'screens/home_screen.dart';
import 'services/audio_player_service.dart';
import 'services/favorites_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final audioService = AudioPlayerService();
  final favoritesService = FavoritesService();
  final appState = AppState(
    audioService: audioService,
    favoritesService: favoritesService,
  );

  await appState.initialize();

  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const BabySleepApp(),
    ),
  );
}

class BabySleepApp extends StatelessWidget {
  const BabySleepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bebek Uyku Sesleri',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const HomeScreen(),
    );
  }
}
