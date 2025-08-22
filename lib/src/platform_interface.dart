import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'listen_callback.dart';
import 'unsupported.dart';

abstract base class FlutterGodotPlatform extends PlatformInterface {
  FlutterGodotPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterGodotPlatform _instance = FlutterGodotUnsupported();

  static FlutterGodotPlatform get instance => _instance;

  static set instance(FlutterGodotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> sendDataToGodot({required String data}) {
    throw UnimplementedError('接口 sendDataToGodot() 未实现.');
  }

  StreamSubscription<dynamic> listenGodotData({
    required GodotListenCallback callback,
  }) {
    throw UnimplementedError('接口 listenGodotData() 未实现.');
  }

  Widget ofPlayer({String? name, String? package}) {
    throw UnimplementedError('接口 ofPlayer() 未实现.');
  }
}
