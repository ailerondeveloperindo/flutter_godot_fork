import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MethodChannel _methodChannel = const MethodChannel(
    "flutter_godot_method",
  );
  final EventChannel _eventStream = const EventChannel("flutter_godot_event");

  StreamSubscription<dynamic>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    startEvent();
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  Future<void> sendDataToGodot(String data) async {
    try {
      await _methodChannel.invokeMethod("sendData2Godot", {"data": data});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void startEvent() {
    _eventSubscription = _eventStream.receiveBroadcastStream().listen(
      (dynamic event) {
        if (event is Map && event["type"] != null) {
          switch (event["type"]) {
            case "takeString":
              debugPrint("Godot发送来的数据是: ${event["data"]}");
              break;
            default:
              debugPrint("Unknown/Unhandled event type: ${event["type"]}");
              break;
          }
        } else {
          debugPrint("Unknown/Unhandled event: $event");
        }
      },
      onError: (error) =>
          debugPrint('Error receiving data from GD-Android: $error'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          const GodotPlayer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      unawaited(sendDataToGodot("这是Flutter发送到Godot的数据"));
                    },
                    child: const Text("发送消息到Godot"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class GodotPlayer extends StatelessWidget {
  const GodotPlayer({super.key});

  static const String viewType = 'godot-player';

  @override
  Widget build(BuildContext context) {
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
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () => params.onFocusChanged(true),
          )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
      viewType: viewType,
    );
  }
}
