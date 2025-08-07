import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';

import 'src/method_channel.dart';
import 'src/platform_interface.dart';
import 'src/typed.dart';
import 'src/unsupported.dart';

export 'src/typed.dart';

final class FlutterGodot implements FlutterGodotPlatform {
  const FlutterGodot();

  static void registerWith() {
    if (Platform.isAndroid) {
      FlutterGodotPlatform.instance = MethodChannelFlutterGodot();
    } else {
      FlutterGodotPlatform.instance = FlutterGodotUnsupported();
    }
  }

  @override
  void sendDataToGodot({required String data}) {
    return FlutterGodotPlatform.instance.sendDataToGodot(data: data);
  }

  @override
  StreamSubscription<dynamic> listenGodotData({
    required GodotListenCallback callback,
  }) {
    return FlutterGodotPlatform.instance.listenGodotData(callback: callback);
  }

  @override
  Widget ofPlayer({required BuildContext context}) {
    return FlutterGodotPlatform.instance.ofPlayer(context: context);
  }
}
