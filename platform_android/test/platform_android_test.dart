import 'package:flutter_test/flutter_test.dart';
import 'package:platform_android/platform_android.dart';
import 'package:platform_android/platform_android_platform_interface.dart';
import 'package:platform_android/platform_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPlatformAndroidPlatform
    with MockPlatformInterfaceMixin
    implements PlatformAndroidPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> openMap({
    required double latitude,
    required double longitude,
    String label = '목적지',
  }) => Future.delayed(Duration(milliseconds: 300));

  @override
  Future<String> getCellphone() => Future.value('010-1234-5678');
}

void main() {
  final PlatformAndroidPlatform initialPlatform =
      PlatformAndroidPlatform.instance;

  test('$MethodChannelPlatformAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPlatformAndroid>());
  });

  test('getPlatformVersion', () async {
    PlatformAndroid platformAndroidPlugin = PlatformAndroid();
    MockPlatformAndroidPlatform fakePlatform = MockPlatformAndroidPlatform();
    PlatformAndroidPlatform.instance = fakePlatform;

    expect(await platformAndroidPlugin.getPlatformVersion(), '42');
  });
}
