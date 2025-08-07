import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'platform_interface.dart';
import 'listen_callback.dart';

final class MethodChannelFlutterGodot extends FlutterGodotPlatform {
  MethodChannelFlutterGodot();

  static const String _viewType = 'godot-player';

  @visibleForTesting
  final MethodChannel methodChannel = const MethodChannel(
    "flutter_godot_method",
  );
  @visibleForTesting
  final EventChannel eventStream = const EventChannel("flutter_godot_event");

  @override
  void sendDataToGodot({required String data}) {
    return unawaited(
      methodChannel.invokeMethod("sendData2Godot", {"data": data}),
    );
  }

  @override
  StreamSubscription<dynamic> listenGodotData({
    required GodotListenCallback callback,
  }) {
    return eventStream.receiveBroadcastStream().listen((dynamic event) {
      if (event is Map && event["type"] != null) {
        switch (event["type"]) {
          case "takeString":
            callback(event["data"]);
            break;
          default:
            debugPrint("未知事件类型: ${event["type"]}");
            break;
        }
      } else {
        debugPrint("未知事件: $event");
      }
    }, onError: (error) => debugPrint(error.toString()));
  }

  @override
  Widget ofPlayer({required BuildContext context}) {
    return PlatformViewLink(
      surfaceFactory:
          (BuildContext context, PlatformViewController controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
              gestureRecognizers:
                  const <Factory<OneSequenceGestureRecognizer>>{},
            );
          },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        return PlatformViewsService.initExpensiveAndroidView(
            id: params.id,
            viewType: _viewType,
            layoutDirection: TextDirection.ltr,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () => params.onFocusChanged(true),
          )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
      viewType: _viewType,
    );
  }
}
