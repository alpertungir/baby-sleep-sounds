// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Suoni per Dormire Bebè';

  @override
  String get favorites => 'Preferiti';

  @override
  String get playlist => 'Playlist';

  @override
  String get playAll => 'Riproduci tutto';

  @override
  String get playlistHint =>
      'I preferiti vengono riprodotti in ordine. Usa avanti e indietro per cambiare.';

  @override
  String get nextTrack => 'Traccia successiva';

  @override
  String get previousTrack => 'Traccia precedente';

  @override
  String get refreshCatalog => 'Aggiorna catalogo';

  @override
  String get refreshCatalogInProgress => 'Aggiornamento catalogo…';

  @override
  String refreshCatalogUpdated(int count) {
    return 'Catalogo aggiornato · $count suoni';
  }

  @override
  String get refreshCatalogUpToDate => 'Il catalogo è già aggiornato.';

  @override
  String refreshCatalogUsedCache(int count) {
    return 'Server non raggiungibile. Catalogo salvato ($count suoni).';
  }

  @override
  String refreshCatalogOffline(int count) {
    return 'Offline. Catalogo locale ($count suoni).';
  }

  @override
  String get language => 'Lingua';

  @override
  String get systemLanguage => 'Lingua di sistema';

  @override
  String get turkish => 'Türkçe';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Français';

  @override
  String get german => 'Deutsch';

  @override
  String get italian => 'Italiano';

  @override
  String get russian => 'Русский';

  @override
  String get arabic => 'العربية';

  @override
  String soundCount(int count) {
    return '$count suoni';
  }

  @override
  String get categoryWhiteNoise => 'Rumore bianco';

  @override
  String get categoryLullaby => 'Ninne';

  @override
  String get categoryRelaxing => 'Rilassante';

  @override
  String get categoryMusic => 'Musica';

  @override
  String get homeHeaderSubtitle => 'Sonno tranquillo, sogni dolci';

  @override
  String get developedBy => 'Tngr Studio';

  @override
  String versionLabel(String version) {
    return 'Versione $version';
  }

  @override
  String get favoritesEmptyTitle => 'Nessun preferito';

  @override
  String get favoritesEmptyBody =>
      'Tocca il cuore su un suono per aggiungerlo qui.';

  @override
  String get emptyCategory => 'Nessun suono in questa categoria';

  @override
  String get downloadOnFirstPlay => 'Si scarica al primo ascolto';

  @override
  String downloadFailed(String error) {
    return 'Impossibile scaricare il suono: $error';
  }

  @override
  String get sleepTimer => 'Timer del sonno';

  @override
  String get sleepTimerHint =>
      'Il suono si ripete fino alla fine del tempo selezionato.';

  @override
  String minutesOption(int count) {
    return '$count min';
  }

  @override
  String get unlimited => 'Illimitato';

  @override
  String get cancelTimer => 'Annulla timer';

  @override
  String timerRemaining(String time) {
    return 'Rimanente: $time';
  }

  @override
  String playingStatus(String time) {
    return 'In riproduzione · $time';
  }

  @override
  String get pausedStatus => 'In pausa';

  @override
  String get supportMenu => 'Sostieni lo sviluppo';

  @override
  String get rateApp => 'Valuta l\'app';

  @override
  String get supportLink => 'Sostieni lo sviluppo';

  @override
  String get supportTitle => 'Supporto volontario';

  @override
  String get supportBody =>
      'Questa app è gratuita e senza pubblicità. Se ti piace, puoi sostenere lo sviluppo in modo volontario. Nessuna funzione è bloccata.';

  @override
  String get supportCoffeeTitle => 'Un caffè';

  @override
  String get supportCoffeeSubtitle => 'Un piccolo ringraziamento';

  @override
  String get supportMealTitle => 'Un pasto';

  @override
  String get supportMealSubtitle => 'Sostieni lo sviluppo';

  @override
  String get supportGenerousTitle => 'Supporto generoso';

  @override
  String get supportGenerousSubtitle => 'Grazie extra';

  @override
  String get supportThankYou => 'Grazie per il tuo supporto!';

  @override
  String get supportUnavailable =>
      'Le opzioni di supporto non sono disponibili al momento. Riprova più tardi.';

  @override
  String get supportProductsPending =>
      'Gli acquisti saranno disponibili quando i prodotti saranno attivi in Play Console.';

  @override
  String get supportPricePending => 'Presto';

  @override
  String get supportPurchasing => 'Elaborazione…';

  @override
  String get supportPurchaseFailed =>
      'Impossibile completare l\'acquisto. Riprova.';

  @override
  String get homeSupportCta => 'Offrimi un caffè';

  @override
  String get homeSupportHint => 'Supporto volontario · App senza pubblicità';
}
