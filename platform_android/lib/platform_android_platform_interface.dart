import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'platform_android_method_channel.dart';

abstract class PlatformAndroidPlatform extends PlatformInterface {
  /// Constructs a PlatformAndroidPlatform.
  PlatformAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlatformAndroidPlatform _instance = MethodChannelPlatformAndroid();

  /// The default instance of [PlatformAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelPlatformAndroid].
  static PlatformAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformAndroidPlatform] when
  /// they register themselves.
  static set instance(PlatformAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> openMap({
    required double latitude,
    required double longitude,
    required String label,
  }) {
    throw UnimplementedError('openMap() has not been implemented.');
  }

  Future<String> getCellphone() {
    throw UnimplementedError('getCellphone() has not been implemented.');
  }
}
