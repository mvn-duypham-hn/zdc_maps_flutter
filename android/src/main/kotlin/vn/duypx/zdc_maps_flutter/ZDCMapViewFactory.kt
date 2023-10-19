package vn.duypx.zdc_maps_flutter

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class ZDCMapViewFactory(
    binaryMessenger: BinaryMessenger,
    context: Context,
    private val lifecycleProvider: LifecycleProvider
) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return ZDCMapView(context, viewId, lifecycleProvider, creationParams)
    }
}