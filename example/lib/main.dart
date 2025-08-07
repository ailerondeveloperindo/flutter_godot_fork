import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_godot/flutter_godot.dart';
import 'package:freefeos/freefeos.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Godot',
      builder: FreeFEOS.builder,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

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
    return Stack(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: godot.ofPlayer(context: context),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: SafeArea(child: CapsulePlaceholder()),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  godot.sendDataToGodot(data: '这是Flutter发送到Godot的数据');
                },
                child: const Text("发送消息到Godot"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final class CapsulePlaceholder extends StatelessWidget {
  const CapsulePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: SizedBox(width: 87.0, height: 32.0),
    );
  }
}
