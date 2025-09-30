# flutter_godot

README Language: [简体中文](https://github.com/wyq0918dev/flutter_godot/blob/master/README.md) [English](https://github.com/wyq0918dev/flutter_godot/blob/master/README.en.md)

`flutter_godot` 插件可以将 Godot 游戏作为 Widget 嵌入到 Flutter 应用中, 并支持双向通信.

![GitHub License](https://img.shields.io/github/license/wyq0918dev/flutter_godot?style=flat-square&logo=github&logoColor=white&label=GitHub%20License)

<img src="https://raw.githubusercontent.com/wyq0918dev/flutter_godot/master/screenshot.png" width="256">

## 对应版本

flutter_godot 插件版本 | Flutter 版本 | Godot Engine 版本
---- | ---- | ----
0.0.1 | 3.32 | 4.4.1
0.0.2 | 3.32 | 4.4.1
0.0.3 | 3.35 | 4.4.1

## 使用方法

1. 新建 Flutter 项目, 或使用现有 Flutter 项目.

2. 在 `pubspec.yaml` 中添加依赖

    ```yaml
    dependencies:
      flutter_godot: ^latest
    ```

3. 更新依赖

    ```shell
    flutter pub get
    ```

4. 在代码中导入依赖

    ```dart
    import 'package:flutter_godot/flutter_godot.dart';
    ```

5. Godot 工程有两种开发模式:

    - **集成模式**: 在 Flutter 项目的 Android 平台工程中创建 `assets` 文件夹 (`android\app\src\main\assets`) 并在其中创建 Godot 工程或将现有 Godot 工程放置在其中.

    - **独立模式**: 将 Godot 工程作为独立的工程单独管理, 然后导出 `.pck` 或 `.zip` 包, 并放入 flutter 项目的 `assets` 文件夹中, 并在代码中指定导出的包的路径及文件名.

6. 实现 Flutter 逻辑 [main.dart](https://github.com/wyq0918dev/flutter_godot/blob/master/example/lib/main.dart) (点击查看完整源码)

7. 实现 Godot 逻辑 [main.gd](https://github.com/wyq0918dev/flutter_godot/blob/master/example/android/app/src/main/assets/main.gd) (点击查看完整源码)

## 已知问题

- 由于 Godot 官方只提供 Android 平台库, 所以此插件仅支持 Android 平台, 并在其他平台做了兼容处理, 不会导致应用崩溃.
- 由于 Flutter 平台组件限制, HotRestart 会导致 Godot 不显示, 请尽量使用 HotReload , 或者重新编译应用.
- 概率退出后重新打开出现闪退 (Bug).
