
import 'flutter_godot_platform_interface.dart';

class FlutterGodot {
  Future<String?> getPlatformVersion() {
    return FlutterGodotPlatform.instance.getPlatformVersion();
  }
}
