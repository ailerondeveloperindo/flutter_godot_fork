/// flutter_godot
library;

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';

import 'src/method_channel.dart';
import 'src/platform_interface.dart';
import 'src/listen_callback.dart';
import 'src/unsupported.dart';

export 'src/listen_callback.dart';

/// 将 Godot 游戏作为 Widget 嵌入到 Flutter 应用程序中.
final class FlutterGodot implements FlutterGodotPlatform {
  const FlutterGodot();

  /// 注册 flutter_godot 插件.
  /// 插件注册由 Flutter 框架接管请勿手动注册.
  static void registerWith() {
    if (Platform.isAndroid) {
      FlutterGodotPlatform.instance = MethodChannelFlutterGodot();
    } else {
      FlutterGodotPlatform.instance = FlutterGodotUnsupported();
    }
  }

  /// 发送数据到 Godot
  @override
  void sendDataToGodot({required String data}) {
    return FlutterGodotPlatform.instance.sendDataToGodot(data: data);
  }

  /// 监听 Godot 发送来的数据
  @override
  StreamSubscription<dynamic> listenGodotData({
    required GodotListenCallback callback,
  }) {
    return FlutterGodotPlatform.instance.listenGodotData(callback: callback);
  }

  /// 游戏播放器
  @override
  Widget ofPlayer({required BuildContext context}) {
    return FlutterGodotPlatform.instance.ofPlayer(context: context);
  }
}
