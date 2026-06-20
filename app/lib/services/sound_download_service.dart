import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../models/sound_item.dart';

class SoundDownloadService {
  SoundDownloadService({FirebaseStorage? storage}) : _storage = storage;

  final FirebaseStorage? _storage;

  FirebaseStorage get _storageOrThrow {
    if (_storage != null) return _storage;
    if (Firebase.apps.isEmpty) {
      throw StateError('Firebase yapılandırılmamış. Uzaktan sesler yalnızca Android/iOS\'ta çalışır.');
    }
    return FirebaseStorage.instance;
  }

  Future<File> resolveLocalFile(SoundItem sound) async {
    if (sound.isBundled) {
      throw StateError('Bundled sound has no local file: ${sound.id}');
    }

    final file = await _cacheFile(sound.storagePath!);
    if (await file.exists()) {
      return file;
    }

    await file.parent.create(recursive: true);
    final ref = _storageOrThrow.ref(sound.storagePath!);
    await ref.writeToFile(file);
    return file;
  }

  Future<bool> isDownloaded(SoundItem sound) async {
    if (sound.isBundled) return true;
    final file = await _cacheFile(sound.storagePath!);
    return file.exists();
  }

  Future<File> _cacheFile(String storagePath) async {
    final root = await getApplicationDocumentsDirectory();
    return File('${root.path}/$storagePath');
  }
}
