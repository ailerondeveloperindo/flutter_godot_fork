import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_godot_method_channel.dart';

abstract class FlutterGodotPlatform extends PlatformInterface {
  /// Constructs a FlutterGodotPlatform.
  FlutterGodotPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterGodotPlatform _instance = MethodChannelFlutterGodot();

  /// The default instance of [FlutterGodotPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterGodot].
  static FlutterGodotPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterGodotPlatform] when
  /// they register themselves.
  static set instance(FlutterGodotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
