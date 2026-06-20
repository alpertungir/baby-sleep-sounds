import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'screens/home_screen.dart';
import 'services/audio_player_service.dart';
import 'services/favorites_service.dart';
import 'services/sound_download_service.dart';
import 'theme/app_theme.dart';

bool get _firebaseSupported =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (_firebaseSupported) {
    await Firebase.initializeApp();
  }

  final downloadService = SoundDownloadService();
  final audioService = AudioPlayerService(downloadService: downloadService);
  final favoritesService = FavoritesService();
  final appState = AppState(
    audioService: audioService,
    favoritesService: favoritesService,
    downloadService: downloadService,
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
