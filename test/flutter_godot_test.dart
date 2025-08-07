import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_godot/src/method_channel.dart';
import 'package:flutter_godot/src/platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_godot/flutter_godot.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterGodotPlatform
    with MockPlatformInterfaceMixin
    implements FlutterGodotPlatform {
  @override
  StreamSubscription listenGodotData({required GodotListenCallback callback}) {
    return Stream.empty().listen((_) {});
  }

  @override
  Widget ofPlayer({required BuildContext context}) {
    return const Placeholder();
  }

  @override
  void sendDataToGodot({required String data}) {
    debugPrint(data);
  }
}

void main() {
  final FlutterGodotPlatform initialPlatform = FlutterGodotPlatform.instance;

  test('$MethodChannelFlutterGodot is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterGodot>());
  });
}
