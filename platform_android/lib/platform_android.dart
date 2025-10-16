import 'platform_android_platform_interface.dart';

class PlatformAndroid {
  Future<String?> getPlatformVersion() {
    return PlatformAndroidPlatform.instance.getPlatformVersion();
  }

  Future<void> openMap({
    required double latitude,
    required double longitude,
    String label = '목적지',
  }) {
    return PlatformAndroidPlatform.instance.openMap(
      latitude: latitude,
      longitude: longitude,
      label: label,
    );
  }

  Future<String?> getCellphone() async {
    try {
      final phone = await PlatformAndroidPlatform.instance.getCellphone();

      String cleaned = phone.replaceAll('-', '').replaceAll(' ', ''); // 기존 '-'와 공백 제거

      if (cleaned.length == 11) {
        return '${cleaned.substring(0, 3)}-${cleaned.substring(3, 7)}-${cleaned.substring(7)}';
      } else if (cleaned.length == 10) {
        return '${cleaned.substring(0, 3)}-${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
      } else {
        return phone;
      }
    } catch (e) {
      return null;
    }
  }


}
