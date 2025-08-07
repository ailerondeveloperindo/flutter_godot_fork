import 'dart:async';

import 'package:flutter/widgets.dart';

import 'platform_interface.dart';
import 'typed.dart';

final class FlutterGodotUnsupported extends FlutterGodotPlatform {
  FlutterGodotUnsupported();

  @override
  StreamSubscription listenGodotData({required GodotListenCallback callback}) {
    return Stream.empty().listen((_) {});
  }

  @override
  void sendDataToGodot({required String data}) {}

  @override
  Widget ofPlayer({required BuildContext context}) {
    return Container();
  }
}
