import 'dart:async';

import 'package:flutter/widgets.dart';

import 'platform_interface.dart';
import 'listen_callback.dart';

final class FlutterGodotUnsupported extends FlutterGodotPlatform {
  FlutterGodotUnsupported();

  @override
  StreamSubscription listenGodotData({required GodotListenCallback callback}) {
    return Stream.empty().listen((_) {});
  }

  @override
  Future<bool> sendDataToGodot({required String data}) async {
    debugPrint('unsupported platform: $data');
    return false;
  }

  @override
  Widget ofPlayer({String? name, String? package}) {
    return Container();
  }
}
