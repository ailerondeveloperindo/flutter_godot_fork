import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_godot_platform_interface.dart';

/// An implementation of [FlutterGodotPlatform] that uses method channels.
class MethodChannelFlutterGodot extends FlutterGodotPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_godot');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
