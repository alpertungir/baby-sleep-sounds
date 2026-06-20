import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'providers/app_state.dart';
import 'providers/locale_provider.dart';
import 'screens/home_screen.dart';
import 'services/audio_player_service.dart';
import 'services/favorites_service.dart';
import 'services/remote_catalog_service.dart';
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
  final remoteCatalogService = RemoteCatalogService();
  final audioService = AudioPlayerService(downloadService: downloadService);
  final favoritesService = FavoritesService();
  final localeProvider = LocaleProvider();
  final appState = AppState(
    audioService: audioService,
    favoritesService: favoritesService,
    downloadService: downloadService,
    remoteCatalogService: remoteCatalogService,
  );

  await localeProvider.load();
  await appState.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider.value(value: appState),
      ],
      child: const BabySleepApp(),
    ),
  );
}

class BabySleepApp extends StatelessWidget {
  const BabySleepApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>().locale;

    return MaterialApp(
      title: 'Baby Sleep Sounds',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
