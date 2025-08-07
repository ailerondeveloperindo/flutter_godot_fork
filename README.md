# flutter_godot

- 将 Godot 游戏作为 Widget 嵌入到 Flutter 应用程序中.  
- Embed a Godot game as a widget in a Flutter app.

![Screenshot](https://raw.githubusercontent.com/wyq0918dev/flutter_godot/master/screenshot.png)

## 对应版本

flutter_godot 插件版本 | Godot Engine 版本
---- | -----
0.0.1 | 4.4.1 Stable

## 使用方法

- 在 pubspec.yaml 中声明依赖

```yaml
dependencies:
  flutter_godot: ^latest
```

- 更新依赖

```shell
flutter pub get
```

- 在代码中导入依赖

```dart
import 'package:flutter_godot/flutter_godot.dart';
```

- 实现 Flutter 逻辑 [main.dart](https://github.com/wyq0918dev/flutter_godot/blob/master/example/lib/main.dart) 点击查看完整源码

- 在 Flutter 项目的 Android 平台工程中创建 Assets 文件夹 (android\app\src\main\assets) 并在其中创建 Godot 工程或将现有 Godot 工程放置在其中. (由于 Godot 官方只提供 Android 平台库, 所以此插件仅支持 Android 平台, 并在其他平台做了兼容处理, 不会导致应用崩溃.)

- 实现Godot逻辑 [main.gd](https://github.com/wyq0918dev/flutter_godot/blob/master/example/android/app/src/main/assets/main.gd) 点击查看完整源码
