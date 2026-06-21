import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> ensureNotificationPermission() async {
  if (kIsWeb || !Platform.isAndroid) return true;

  var status = await Permission.notification.status;
  if (status.isGranted || status.isLimited) return true;

  status = await Permission.notification.request();
  return status.isGranted || status.isLimited;
}
