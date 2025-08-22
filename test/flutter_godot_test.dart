import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_godot/src/listen_callback.dart';
import 'package:flutter_godot/src/android.dart';
import 'package:flutter_godot/src/platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

final class MockFlutterGodotPlatform extends FlutterGodotPlatform
    with MockPlatformInterfaceMixin {
  @override
  StreamSubscription listenGodotData({required GodotListenCallback callback}) {
    return Stream.empty().listen((_) {});
  }

  @override
  Widget ofPlayer({String? name, String? package}) {
    return const Placeholder();
  }

  @override
  Future<bool> sendDataToGodot({required String data}) async {
    debugPrint(data);
    return false;
  }
}

void main() {
  final FlutterGodotPlatform initialPlatform = FlutterGodotPlatform.instance;

  test('$FlutterGodotAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<FlutterGodotAndroid>());
  });
}
