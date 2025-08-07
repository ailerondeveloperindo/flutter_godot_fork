/// flutter_godot_web
library;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/platform_interface.dart';
import 'src/unsupported.dart';

class FlutterGodotWeb {
  const FlutterGodotWeb();

  /// 注册 flutter_godot 插件.
  /// 插件注册由 Flutter 框架接管请勿手动注册.
  /// 为 Web 平台提供兼容处理
  static void registerWith(Registrar _) {
    FlutterGodotPlatform.instance = FlutterGodotUnsupported();
  }
}
