import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Copies bundled artwork to a temp file so Android can show it in the
/// media notification (asset:// URIs are not loaded by audio_service).
final _cache = <String, Uri>{};

Future<Uri?> resolveMediaArtUri(String assetPath) async {
  final cached = _cache[assetPath];
  if (cached != null) return cached;

  try {
    final data = await rootBundle.load(assetPath);
    final dir = await getTemporaryDirectory();
    final fileName = assetPath.replaceAll('/', '_');
    final file = File('${dir.path}/media_art_$fileName');
    if (!await file.exists()) {
      await file.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
    }
    final uri = Uri.file(file.path);
    _cache[assetPath] = uri;
    return uri;
  } catch (_) {
    return null;
  }
}
