package com.wyq0918dev.flutter_godot

import android.app.Activity
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import androidx.annotation.Keep
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.godotengine.godot.Godot
import org.godotengine.godot.GodotHost
import org.godotengine.godot.plugin.GodotPlugin
import org.godotengine.godot.plugin.SignalInfo
import org.godotengine.godot.plugin.UsedByGodot
import org.godotengine.godot.utils.ProcessPhoenix
import java.util.concurrent.atomic.AtomicBoolean

class FlutterGodotPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler,
    EventChannel.StreamHandler {

    /** FlutterHost生命周期 */
    private var mLifecycle: Lifecycle? = null

    /** Flutter Host Activity */
    private var mActivity: Activity? = null

    /** Flutter 方法通道 */
    private lateinit var mMethodChannel: MethodChannel

    /** Flutter 事件通道 */
    private lateinit var mEventChannel: EventChannel

    /** Godot实例 */
    private var mGodot: Godot? = null
    private var initializationContext: Context? = null

    private lateinit var mGodotContainer: FrameLayout

    private var eventSink: EventChannel.EventSink? = null
    private val isListening = AtomicBoolean(false)

    private val commandLineParams = ArrayList<String>()

    private var mAssetName: String? = null

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        mMethodChannel = MethodChannel(binding.binaryMessenger, GODOT_METHOD_ID)
        mEventChannel = EventChannel(binding.binaryMessenger, GODOT_EVENT_ID)
        binding.platformViewRegistry.registerViewFactory(GODOT_VIEW_ID, mFactory)
        mEventChannel.setStreamHandler(this@FlutterGodotPlugin)
        mMethodChannel.setMethodCallHandler(this@FlutterGodotPlugin)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        mMethodChannel.setMethodCallHandler(null)
        mEventChannel.setStreamHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
        mLifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding)
        val params = binding.activity.intent.getStringArrayExtra(EXTRA_COMMAND_LINE_PARAMS)
        commandLineParams.addAll(params ?: emptyArray())
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        mActivity = null
        mLifecycle = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "sendData2Godot" -> call.argument<String>("data")?.let {
                Log.d(TAG, "Received data from flutter... passing to godot")
                if (mGodot != null) {
                    GodotPlugin.emitSignal(
                        mGodot,
                        PLUGIN_NAME,
                        SHOW_STRANG,
                        it,
                    )
                }
                result.success("Data sent to Godot: $it")
            } ?: run {
                Log.e(TAG, "MISSING_DATA")
                result.error("MISSING_DATA", "Data argument is missing", null)
            }

            else -> result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        Log.d(TAG, "onListen -> starting listening")
        if (events != null) {
            eventSink = events
        } else {
            Log.e(TAG, "onListen -> EventSink is null, cannot setup event listening")
            return
        }
        if (isListening.getAndSet(true)) {
            Log.w(TAG, "Already listening for events, ignoring duplicate request")
            return
        }
    }

    override fun onCancel(arguments: Any?) {
        Log.d(TAG, "onCancel -> Stopping Godot event listening")
        if (isListening.getAndSet(false)) {
            eventSink = null
        }
    }


    private val mFactory: PlatformViewFactory by lazy {
        return@lazy object : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
            override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
                return object : PlatformView {
                    init {
                        mAssetName = getAssetName(args = args)
                        mGodotContainer = FrameLayout(context).apply {
                            id = viewId
                        }
                        if (mGodot != null && initializationContext != context) {
                            mHost.onNewGodotInstanceRequested(emptyArray())
                        } else {
                            mLifecycle?.addObserver(mObserver)
                        }
                    }

                    override fun getView(): View = mGodotContainer
                    override fun dispose(): Unit = mGodot?.destroyAndKillProcess() ?: Unit
                }
            }
        }
    }

    private fun getAssetName(args: Any?): String? {
        return (args as? Map<*, *>)?.get(key = ASSET_NAME_KEY) as? String
    }

    private val mHost: GodotHost = object : GodotHost {
        override fun getActivity(): Activity? = mActivity

        override fun getGodot(): Godot {
            if (mGodot == null) {
                initializationContext = mActivity
                mGodot = Godot(mActivity!!)
            }
            return mGodot!!
        }

        override fun onNewGodotInstanceRequested(args: Array<String>): Int {
            Log.d(TAG, "Restarting with parameters ${args.contentToString()}")
            val intent =
                Intent().setComponent(ComponentName(mActivity!!, mActivity!!.javaClass.name))
                    .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    .addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
                    .putExtra(EXTRA_COMMAND_LINE_PARAMS, args).putExtra(KEY_SHOW_GODOT_VIEW, true)
            mHost.godot.destroyAndKillProcess()
            ProcessPhoenix.triggerRebirth(mActivity, Bundle(), intent)
            return DEFAULT_WINDOW_ID
        }

        override fun getHostPlugins(engine: Godot): MutableSet<GodotPlugin> {
            return mutableSetOf<GodotPlugin>().apply {
                add(element = mGodotPlugin)
                addAll(elements = super.getHostPlugins(engine))
            }
        }

        override fun getCommandLine(): List<String?>? {
            return arrayListOf<String?>().apply {
                addAll(commandLineParams)
                mAssetName?.let { asset ->
                    add("--main-pack")
                    add(asset)
                }
            }
        }
    }

    private val mObserver: DefaultLifecycleObserver = object : DefaultLifecycleObserver {
        override fun onCreate(owner: LifecycleOwner) {
            super.onCreate(owner = owner)
            mHost.godot.onCreate(primaryHost = mHost)
            if (mHost.godot.onInitNativeLayer(host = mHost)) {
                mHost.godot.onInitRenderView(
                    host = mHost,
                    providedContainerLayout = mGodotContainer,
                )
            }
        }

        override fun onStart(owner: LifecycleOwner) {
            super.onStart(owner = owner)
            mHost.godot.onStart(host = mHost)
        }

        override fun onResume(owner: LifecycleOwner) {
            super.onResume(owner = owner)
            mHost.godot.onResume(host = mHost)
        }

        override fun onPause(owner: LifecycleOwner) {
            super.onPause(owner = owner)
            mHost.godot.onPause(host = mHost)
        }

        override fun onStop(owner: LifecycleOwner) {
            super.onStop(owner = owner)
            mHost.godot.onStop(host = mHost)
        }

        override fun onDestroy(owner: LifecycleOwner) {
            super.onDestroy(owner = owner)
            mHost.godot.onDestroy(primaryHost = mHost)
        }
    }

    private val mGodotPlugin: GodotPlugin by lazy {
        return@lazy object : GodotPlugin(mGodot) {
            override fun getPluginName(): String = PLUGIN_NAME

            override fun getPluginSignals(): MutableSet<SignalInfo> {
                return mutableSetOf(SHOW_STRANG)
            }

            @Keep
            @UsedByGodot
            fun sendData(string: String) {
                runOnUiThread {
                    sendEvent(
                        event = mapOf(
                            "type" to "takeString",
                            "data" to string,
                        ),
                    )
                }
            }
        }
    }

    private fun sendEvent(event: Map<String, Any?>) {
        if (!isListening.get()) {
            Log.w(TAG, "Attempted to send event while not listening: $event")
            return
        }
        try {
            eventSink?.success(event)
        } catch (e: Exception) {
            eventSink?.error("GODOT_EVENT_ERROR", e.message, null)
        }
    }

    private companion object {
        /** 日志标签 */
        const val TAG = "FlutterGodotPlugin"

        /** 视图ID */
        const val GODOT_VIEW_ID: String = "godot-player"
        const val GODOT_METHOD_ID: String = "flutter_godot_method"
        const val GODOT_EVENT_ID: String = "flutter_godot_event"

        const val ASSET_NAME_KEY = "asset_name"

        private const val EXTRA_COMMAND_LINE_PARAMS = "command_line_params"
        private const val DEFAULT_WINDOW_ID = 664
        private const val KEY_SHOW_GODOT_VIEW = "SHOW_GODOT_VIEW"

        private const val PLUGIN_NAME = "GodotFlutterPlugin"
        private val SHOW_STRANG = SignalInfo("get_stang", String::class.java)
    }
}