import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'godot_player.dart';
import 'platform_interface.dart';
import 'listen_callback.dart';

final class FlutterGodotAndroid extends FlutterGodotPlatform {
  FlutterGodotAndroid();

  @visibleForTesting
  final MethodChannel methodChannel = const MethodChannel(
    "flutter_godot_method",
  );

  @visibleForTesting
  final EventChannel eventStream = const EventChannel("flutter_godot_event");

  @override
  void sendDataToGodot({required String data}) {
    return unawaited(
      methodChannel.invokeMethod("sendData2Godot", {"data": data}),
    );
  }

  @override
  StreamSubscription<dynamic> listenGodotData({
    required GodotListenCallback callback,
  }) {
    return eventStream.receiveBroadcastStream().listen((dynamic event) {
      if (event is Map && event["type"] != null) {
        switch (event["type"]) {
          case "takeString":
            callback(event["data"]);
            break;
          default:
            debugPrint("未知事件类型: ${event["type"]}");
            break;
        }
      } else {
        debugPrint("未知事件: $event");
      }
    }, onError: (error) => debugPrint(error.toString()));
  }

  @override
  Widget ofPlayer({String? name, String? package}) {
    return GodotPlayer(name: name, package: package);
  }
}
