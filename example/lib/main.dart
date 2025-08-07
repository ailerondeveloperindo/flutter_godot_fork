import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_godot/flutter_godot.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();

  StreamSubscription? _eventSubscription;
  final FlutterGodot godot = const FlutterGodot();

  @override
  void initState() {
    super.initState();
    _eventSubscription = godot.listenGodotData(
      callback: (data) => debugPrint('Godot发送来的数据是: $data'),
    );
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          godot.ofPlayer(context: context),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      godot.sendDataToGodot(data: '这是Flutter发送到Godot的数据');
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
