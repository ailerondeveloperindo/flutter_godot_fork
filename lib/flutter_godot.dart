/// flutter_godot
library;

import 'dart:async';

import 'package:flutter/widgets.dart';

import 'src/android.dart';
import 'src/platform_interface.dart';
import 'src/listen_callback.dart';
import 'src/unsupported.dart';

/// 导出监听数据的回调
export 'src/listen_callback.dart';

/// 不支持的平台做兼容处理
part 'flutter_godot_compat.dart';

final class FlutterGodot {
  const FlutterGodot._();

  /// 注册 flutter_godot 插件.
  /// 插件注册由 Flutter 框架接管请勿手动注册.
  static void registerWith() {
    FlutterGodotPlatform.instance = FlutterGodotAndroid();
  }

  /// 发送数据到 Godot
  static Future<bool> sendDataToGodot({required String data}) {
    return FlutterGodotPlatform.instance.sendDataToGodot(data: data);
  }

  /// 监听 Godot 发送来的数据
  static StreamSubscription<dynamic> listenGodotData({
    required GodotListenCallback callback,
  }) {
    return FlutterGodotPlatform.instance.listenGodotData(callback: callback);
  }

  static StreamSubscription<dynamic> listenGodotHostCallbacks({
    required GodotListenCallback callback,
  }) {
    return FlutterGodotPlatform.instance.listenGodotHostCallbacks(callback: callback);
  }

  /// 游戏播放器
  static Widget ofPlayer({String? name, String? package, String compositionMode = FlutterGodotAndroid.compositionModeHybrid}) {
    return FlutterGodotPlatform.instance.ofPlayer(name: name, package: package);
  }
}
