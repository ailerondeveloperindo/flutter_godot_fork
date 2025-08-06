package com.wyq0918dev.flutter_godot

import android.util.Log
import org.godotengine.godot.Godot
import org.godotengine.godot.plugin.GodotPlugin
import org.godotengine.godot.plugin.SignalInfo
import org.godotengine.godot.plugin.UsedByGodot

class GodotFlutterPlugin(godot: Godot, flutter: FlutterGodotPlugin) : GodotPlugin(godot) {

    private val mFlutterPlugin: FlutterGodotPlugin = flutter

    override fun getPluginName(): String = PLUGIN_NAME

    override fun getPluginSignals(): MutableSet<SignalInfo> {
        return mutableSetOf(SHOW_STRANG)
    }

    @UsedByGodot
    fun sendData(string: String) {
        Log.d(TAG, "sendData")
        // send to flutter
        runOnUiThread {
            mFlutterPlugin.sendEvent(event = mapOf("type" to "takeString", "data" to string))
        }
    }

    companion object {
        private const val TAG = "GodotFlutterPlugin"
        const val PLUGIN_NAME = "GodotFlutterPlugin"
        val SHOW_STRANG = SignalInfo("get_stang", String::class.java)
    }
}


