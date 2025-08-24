# flutter_godot (English)

README Language: [简体中文](https://github.com/wyq0918dev/flutter_godot/blob/master/README.md) [English](https://github.com/wyq0918dev/flutter_godot/blob/master/README.en.md)

The `flutter_godot` plugin allows you to embed Godot games as Widgets in Flutter applications, supporting two-way communication between Flutter and Godot.

![Pub Version](https://img.shields.io/pub/v/flutter_godot?style=flat-square&logo=dart&logoColor=white&label=Pub%20Version&color=blue)
![GitHub Repo stars](https://img.shields.io/github/stars/wyq0918dev/flutter_godot?style=flat-square&logo=github&logoColor=white&label=GitHub%20Stars&color=blue)
![GitHub License](https://img.shields.io/github/license/wyq0918dev/flutter_godot?style=flat-square&logo=github&logoColor=white&label=GitHub%20License)

<img src="https://raw.githubusercontent.com/wyq0918dev/flutter_godot/master/screenshot.png" width="256">

## Supported Versions

| flutter_godot Version | Flutter Version | Godot Engine Version |
|----------------------|----------------|---------------------|
| 0.0.1                | 3.32           | 4.4.1               |
| 0.0.2                | 3.32           | 4.4.1               |
| 0.0.3                | 3.35           | 4.4.1               |

## Usage

1. Create a new Flutter project or use an existing one.

2. Add the dependency in your `pubspec.yaml`:

    ```yaml
    dependencies:
      flutter_godot: ^latest
    ```

3. Update dependencies:

    ```shell
    flutter pub get
    ```

4. Import the package in your code:

    ```dart
    import 'package:flutter_godot/flutter_godot.dart';
    ```

5. There are two development modes for Godot projects:
   - **Integrated Mode**: Create an `assets` folder in your Flutter project's Android platform (`android/app/src/main/assets`) and place your Godot project there, or move an existing Godot project into it.
   - **Standalone Mode**: Manage the Godot project separately, export the `.pck` or `.zip` package, and place it in the Flutter project's `assets` folder. Specify the exported package's path and filename in your code.

6. Implement Flutter logic ([main.dart](https://github.com/wyq0918dev/flutter_godot/blob/master/example/lib/main.dart))

7. Implement Godot logic ([main.gd](https://github.com/wyq0918dev/flutter_godot/blob/master/example/android/app/src/main/assets/main.gd))

## Known Issues

- The plugin only supports Android, as Godot officially provides libraries for Android only. Other platforms are handled for compatibility and will not crash the app.
- Due to Flutter platform component limitations, HotRestart may cause Godot to not display. Prefer using HotReload or recompiling the app.
- There is a bug where reopening the app after exit may cause a crash occasionally.
