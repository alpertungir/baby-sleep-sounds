import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoData {
  const PackageInfoData({required this.version, required this.buildNumber});

  final String version;
  final String buildNumber;
}

class PackageInfoLoader {
  PackageInfoLoader._();

  static final instance = PackageInfoLoader._();

  PackageInfoData? _cached;

  Future<PackageInfoData> load() async {
    if (_cached != null) return _cached!;
    final info = await PackageInfo.fromPlatform();
    _cached = PackageInfoData(version: info.version, buildNumber: info.buildNumber);
    return _cached!;
  }
}
