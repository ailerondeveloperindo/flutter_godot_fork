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
  void sendDataToGodot({required String data}) {
    return debugPrint(data);
  }

  @override
  Widget ofPlayer({required BuildContext context}) {
    return Container();
  }
}
