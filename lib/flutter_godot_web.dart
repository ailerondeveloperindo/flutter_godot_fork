import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/platform_interface.dart';
import 'src/unsupported.dart';

class FlutterGodotWeb {
  const FlutterGodotWeb();

  static void registerWith(Registrar _) {
    FlutterGodotPlatform.instance = FlutterGodotUnsupported();
  }
}
