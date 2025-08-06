#ifndef FLUTTER_PLUGIN_FLUTTER_GODOT_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_GODOT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_godot {

class FlutterGodotPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterGodotPlugin();

  virtual ~FlutterGodotPlugin();

  // Disallow copy and assign.
  FlutterGodotPlugin(const FlutterGodotPlugin&) = delete;
  FlutterGodotPlugin& operator=(const FlutterGodotPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_godot

#endif  // FLUTTER_PLUGIN_FLUTTER_GODOT_PLUGIN_H_
