// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'أصوات نوم الطفل';

  @override
  String get favorites => 'المفضلة';

  @override
  String get refreshCatalog => 'تحديث الفهرس';

  @override
  String get language => 'اللغة';

  @override
  String get systemLanguage => 'لغة الجهاز';

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
    return '$count صوت';
  }

  @override
  String get categoryWhiteNoise => 'الضوضاء البيضاء';

  @override
  String get categoryLullaby => 'تهويدات';

  @override
  String get categoryRelaxing => 'مريح';

  @override
  String get categoryMusic => 'موسيقى';

  @override
  String get homeHeaderSubtitle => 'نوم هادئ، أحلام جميلة';

  @override
  String get developedBy => 'Tngr Studio';

  @override
  String versionLabel(String version) {
    return 'الإصدار $version';
  }

  @override
  String get favoritesEmptyTitle => 'لا توجد مفضلات بعد';

  @override
  String get favoritesEmptyBody => 'اضغط على القلب بجانب الصوت لإضافته هنا.';

  @override
  String get emptyCategory => 'لا توجد أصوات في هذه الفئة';

  @override
  String get downloadOnFirstPlay => 'يُحمَّل عند أول تشغيل';

  @override
  String downloadFailed(String error) {
    return 'تعذّر تحميل الصوت: $error';
  }

  @override
  String get sleepTimer => 'مؤقت النوم';

  @override
  String get sleepTimerHint => 'يتكرر الصوت حتى انتهاء الوقت المحدد.';

  @override
  String minutesOption(int count) {
    return '$count دقيقة';
  }

  @override
  String get unlimited => 'غير محدود';

  @override
  String get cancelTimer => 'إلغاء المؤقت';

  @override
  String timerRemaining(String time) {
    return 'المتبقي: $time';
  }

  @override
  String playingStatus(String time) {
    return 'تشغيل · $time';
  }

  @override
  String get pausedStatus => 'متوقف مؤقتًا';

  @override
  String get supportMenu => 'ادعم التطوير';

  @override
  String get supportLink => 'ادعم التطوير';

  @override
  String get supportTitle => 'دعم اختياري';

  @override
  String get supportBody =>
      'هذا التطبيق مجاني وبدون إعلانات. إذا أعجبك، يمكنك دعم التطوير بشكل اختياري. لا توجد ميزات مقفلة.';

  @override
  String get supportCoffeeTitle => 'فنجان قهوة';

  @override
  String get supportCoffeeSubtitle => 'شكر بسيط';

  @override
  String get supportMealTitle => 'وجبة';

  @override
  String get supportMealSubtitle => 'ادعم التطوير';

  @override
  String get supportGenerousTitle => 'دعم سخي';

  @override
  String get supportGenerousSubtitle => 'شكر إضافي';

  @override
  String get supportThankYou => 'شكرًا لدعمك!';

  @override
  String get supportUnavailable =>
      'خيارات الدعم غير متاحة حاليًا. حاول لاحقًا.';

  @override
  String get supportProductsPending =>
      'تتوفر المشتريات بعد تفعيل المنتجات في Play Console.';

  @override
  String get supportPricePending => 'قريبًا';

  @override
  String get supportPurchasing => 'جارٍ المعالجة…';

  @override
  String get supportPurchaseFailed => 'تعذّر إتمام الشراء. حاول مرة أخرى.';

  @override
  String get homeSupportCta => 'ادعمني بقهوة';

  @override
  String get homeSupportHint => 'دعم اختياري · بدون إعلانات';
}
