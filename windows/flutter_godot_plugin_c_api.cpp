#include "include/flutter_godot/flutter_godot_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_godot_plugin.h"

void FlutterGodotPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_godot::FlutterGodotPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
