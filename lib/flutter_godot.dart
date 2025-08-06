import 'flutter_godot_platform_interface.dart';

final class FlutterGodot {
  const FlutterGodot();

  static void registerWith() {}

  Future<String?> getPlatformVersion() {
    return FlutterGodotPlatform.instance.getPlatformVersion();
  }
}
