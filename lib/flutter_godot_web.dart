/// flutter_godot_web
library;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/platform_interface.dart';
import 'src/unsupported.dart';

/// 将 Godot 游戏作为 Widget 嵌入到 Flutter 应用程序中.
class FlutterGodotWeb {
  const FlutterGodotWeb();

  /// 注册 flutter_godot 插件.
  /// 插件注册由Flutter框架接管请勿手动注册.
  static void registerWith(Registrar _) {
    FlutterGodotPlatform.instance = FlutterGodotUnsupported();
  }
}
