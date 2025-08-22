import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'godot_player.dart';
import 'platform_interface.dart';
import 'listen_callback.dart';

final class FlutterGodotAndroid extends FlutterGodotPlatform {
  FlutterGodotAndroid();

  final MethodChannel methodChannel = const MethodChannel(
    "flutter_godot_method",
  );

  final EventChannel eventStream = const EventChannel("flutter_godot_event");

  /// 发送数据到 Godot
  @override
  Future<bool> sendDataToGodot({required String data}) {
    return methodChannel
        .invokeMethod<bool>("sendData2Godot", {"data": data})
        .then((result) => result == true)
        .catchError((error) => throw FlutterError(error.toString()));
  }

  /// 监听 Godot 发送来的数据
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

  /// 游戏播放器
  @override
  Widget ofPlayer({String? name, String? package}) {
    return GodotPlayer(name: name, package: package);
  }
}
