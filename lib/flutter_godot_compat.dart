part of 'flutter_godot.dart';

final class FlutterGodotCompat {
  const FlutterGodotCompat._();

  /// 注册 flutter_godot 插件.
  /// 插件注册由 Flutter 框架接管请勿手动注册.
  /// 为不支持的平台提供兼容处理
  static void registerWith() {
    FlutterGodotPlatform.instance = FlutterGodotUnsupported();
  }
}
