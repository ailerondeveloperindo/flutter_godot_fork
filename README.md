# flutter_godot

- 将 Godot 游戏作为 Widget 嵌入到 Flutter 应用程序中.  
- Embed a Godot game as a widget in a Flutter app.

## 对应版本

flutter_godot 插件版本 | Godot Engine 版本
---- | -----
0.0.1 | 4.4.1 Stable

## 使用方法

- 在pubspec.yaml中声明依赖

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

- 实现Flutter逻辑 [main.dart](https://github.com/wyq0918dev/flutter_godot/blob/master/example/lib/main.dart) 点击查看完整源码

- 在Flutter项目的Android平台工程中创建Assets文件夹 (android\app\src\main\assets) 并在其中创建Godot工程或将现有Godot工程放置在其中. (由于Godot官方只提供Android平台库, 所以此插件仅支持Android平台).

- 实现Godot逻辑 [main.gd](https://github.com/wyq0918dev/flutter_godot/blob/master/example/android/app/src/main/assets/main.gd) 点击查看完整源码
