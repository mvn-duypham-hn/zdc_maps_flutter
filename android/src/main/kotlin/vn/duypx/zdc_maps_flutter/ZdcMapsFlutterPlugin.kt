package vn.duypx.zdc_maps_flutter

import androidx.annotation.Nullable
import androidx.lifecycle.Lifecycle
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;


/** ZdcMapsFlutterPlugin */
class ZdcMapsFlutterPlugin : FlutterPlugin, ActivityAware {

    private val viewType = "vn.duypx/zdc_maps_view_type"

    @Nullable
    var lifecycle: Lifecycle? = null

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        lifecycle = null
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.platformViewRegistry.registerViewFactory(
            viewType,
            ZDCMapViewFactory(binding.binaryMessenger,
                binding.applicationContext,
                object : LifecycleProvider {
                    override fun getLifecycle(): Lifecycle? {
                        return lifecycle
                    }

                })
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
