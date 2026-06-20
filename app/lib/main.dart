import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'providers/app_state.dart';
import 'providers/locale_provider.dart';
import 'screens/app_root.dart';
import 'services/audio_player_service.dart';
import 'services/favorites_service.dart';
import 'services/remote_catalog_service.dart';
import 'services/sleep_audio_handler.dart';
import 'services/sound_download_service.dart';
import 'theme/app_theme.dart';

bool get _mobilePlatform =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (_mobilePlatform) {
    await Firebase.initializeApp();
  }

  final downloadService = SoundDownloadService();
  final remoteCatalogService = RemoteCatalogService();

  SleepAudioHandler? handler;
  if (_mobilePlatform) {
    handler = await AudioService.init(
      builder: () => SleepAudioHandler(downloadService),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.alfaapps.BabySleepSounds.audio',
        androidNotificationChannelName: 'Bebek Uyku Sesleri',
        androidNotificationOngoing: true,
      ),
    ) as SleepAudioHandler;
  }

  final audioService = AudioPlayerService(
    downloadService: downloadService,
    handler: handler,
  );
  final favoritesService = FavoritesService();
  final localeProvider = LocaleProvider(
    systemLocale: WidgetsBinding.instance.platformDispatcher.locale,
  );
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
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      title: 'Baby Sleep Sounds',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      locale: localeProvider.effectiveLocale,
      localeResolutionCallback: (locale, supported) {
        if (locale == null) return const Locale('tr');
        for (final supportedLocale in supported) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('tr');
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AppRoot(),
    );
  }
}
