import 'package:flutter/material.dart';

import '../providers/app_state.dart';

/// Shared bottom spacing so lists and the mini player clear gesture navigation.
class ScreenInsets {
  static double viewBottom(BuildContext context) =>
      MediaQuery.viewPaddingOf(context).bottom;

  static const double miniPlayerHeight = 78;
  static const double supportFooterHeight = 52;

  static double listBottom(
    BuildContext context,
    AppState state, {
    bool includeSupportFooter = false,
  }) {
    final base = viewBottom(context) + 12;
    if (state.currentSound != null) return base + miniPlayerHeight + 8;
    if (includeSupportFooter) {
      return base + supportFooterHeight + 8;
    }
    return base;
  }

  static double miniPlayerBottom(BuildContext context) {
    final inset = viewBottom(context);
    return inset > 0 ? inset + 6 : 12;
  }
}
