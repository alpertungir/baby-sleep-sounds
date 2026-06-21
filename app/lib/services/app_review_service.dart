import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppReviewService {
  AppReviewService({bool enabled = true}) : _enabled = enabled;

  static const _keyLaunches = 'review_app_launches';
  static const _keyPlaybackSessions = 'review_playback_sessions';
  static const _keyPrompted = 'review_prompted';

  static const minLaunches = 3;
  static const minPlaybackSessions = 2;

  final bool _enabled;

  Future<void> recordLaunch() async {
    if (!_enabled) return;
    final prefs = await SharedPreferences.getInstance();
    final launches = prefs.getInt(_keyLaunches) ?? 0;
    await prefs.setInt(_keyLaunches, launches + 1);
  }

  Future<void> recordPlaybackSession() async {
    if (!_enabled) return;
    final prefs = await SharedPreferences.getInstance();
    final sessions = prefs.getInt(_keyPlaybackSessions) ?? 0;
    await prefs.setInt(_keyPlaybackSessions, sessions + 1);
  }

  Future<void> maybeRequestReview() async {
    if (!_enabled || kDebugMode) return;

    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_keyPrompted) == true) return;

    final launches = prefs.getInt(_keyLaunches) ?? 0;
    final sessions = prefs.getInt(_keyPlaybackSessions) ?? 0;
    if (launches < minLaunches || sessions < minPlaybackSessions) return;

    final shown = await _requestInAppReview();
    if (shown) {
      await prefs.setBool(_keyPrompted, true);
    }
  }

  /// Menüden tetiklenir: önce uygulama içi puanlama, olmazsa mağaza sayfası.
  Future<bool> requestReviewManually() async {
    if (!_enabled) return false;

    if (await _requestInAppReview()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyPrompted, true);
      return true;
    }

    return openStoreListing();
  }

  Future<bool> _requestInAppReview() async {
    final review = InAppReview.instance;
    if (!await review.isAvailable()) return false;
    await review.requestReview();
    return true;
  }

  Future<bool> openStoreListing() async {
    if (!_enabled) return false;
    final review = InAppReview.instance;
    if (!await review.isAvailable()) return false;
    await review.openStoreListing();
    return true;
  }
}
