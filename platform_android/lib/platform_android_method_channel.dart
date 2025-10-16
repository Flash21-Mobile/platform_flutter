import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'platform_android_platform_interface.dart';

/// An implementation of [PlatformAndroidPlatform] that uses method channels.
class MethodChannelPlatformAndroid extends PlatformAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('platform_android');

  @override
  Future<void> openMap({
    required double latitude,
    required double longitude,
    String label = '목적지',
  }) async {
    await methodChannel.invokeMethod('openMap', {
      'lat': latitude,
      'lng': longitude,
      'label': label,
    });
  }

  @override
  Future<String> getCellphone() async {
    return await methodChannel.invokeMethod('getCellphone');
  }
}
