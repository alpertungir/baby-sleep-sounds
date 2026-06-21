import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> ensureNotificationPermission() async {
  if (kIsWeb || !Platform.isAndroid) return;

  final status = await Permission.notification.status;
  if (status.isGranted || status.isLimited) return;

  await Permission.notification.request();
}
