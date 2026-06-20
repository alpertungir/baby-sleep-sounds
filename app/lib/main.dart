import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'config/app_identity.dart';
import 'l10n/app_locales.dart';
import 'l10n/app_localizations.dart';
import 'providers/app_state.dart';
import 'providers/locale_provider.dart';
import 'providers/support_purchase_provider.dart';
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
        androidNotificationChannelId: AppIdentity.androidNotificationChannelId,
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
  final supportPurchaseProvider = SupportPurchaseProvider();
  final appState = AppState(
    audioService: audioService,
    favoritesService: favoritesService,
    downloadService: downloadService,
    remoteCatalogService: remoteCatalogService,
  );

  await localeProvider.load();
  if (_mobilePlatform) {
    await supportPurchaseProvider.initialize();
  }
  await appState.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider.value(value: supportPurchaseProvider),
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

    final locale = localeProvider.effectiveLocale;

    return MaterialApp(
      key: ValueKey(locale.languageCode),
      title: 'Baby Sleep Sounds',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      locale: locale,
      localeResolutionCallback: (locale, supported) {
        if (locale != null && AppLocales.isSupported(locale.languageCode)) {
          return Locale(locale.languageCode);
        }
        for (final supportedLocale in supported) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('en');
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
