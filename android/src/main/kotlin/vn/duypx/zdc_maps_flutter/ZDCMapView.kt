package vn.duypx.zdc_maps_flutter

import android.content.Context
import android.os.Bundle
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import com.zdc.android.zms.maps.CameraUpdateFactory
import com.zdc.android.zms.maps.MapView
import com.zdc.android.zms.maps.OnMapReadyCallback
import com.zdc.android.zms.maps.ZDCMap
import com.zdc.android.zms.maps.ZDCMapOptions
import com.zdc.android.zms.maps.model.CameraPosition
import com.zdc.android.zms.maps.model.LatLng
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.platform.PlatformView


internal class ZDCMapView(
    context: Context,
    id: Int,
    lifecycleProvider: LifecycleProvider,
    creationParams: Map<String?, Any?>?
) :
    PlatformView, OnMapReadyCallback, ActivityPluginBinding.OnSaveInstanceStateListener,
    DefaultLifecycleObserver {

    private var lifecycleProvider: LifecycleProvider
    private var mapView: MapView
    private var disposed = false

    override fun getView(): View {
        return mapView
    }

    init {
        mapView = MapView(
            context, ZDCMapOptions()
                .camera(CameraPosition(LatLng(35.68, 139.76), 14.0, 0f, 0f))
                .mapType("its-mo")
        )

        this.lifecycleProvider = lifecycleProvider
        lifecycleProvider.getLifecycle()?.addObserver(this)
        mapView.getMapAsync(this)
    }

    override fun onMapReady(zdcMap: ZDCMap?) {
        zdcMap?.mapType = "its-mo"
        zdcMap?.moveCamera(
            CameraUpdateFactory.newLatLngZoom(
                LatLng(
                    35.68,
                    139.76
                ), 6.0
            )
        )
    }

    // DefaultLifecycleObserver
    override fun onCreate(owner: LifecycleOwner) {
        if (disposed) {
            return
        }
        mapView.onCreate(null)
    }

    override fun onStart(owner: LifecycleOwner) {
        if (disposed) {
            return
        }
    }

    override fun onResume(owner: LifecycleOwner) {
        if (disposed) {
            return
        }
        mapView.onResume()
    }

    override fun onPause(owner: LifecycleOwner) {
        if (disposed) {
            return
        }
        mapView.onResume()
    }

    override fun onStop(owner: LifecycleOwner) {
        if (disposed) {
            return
        }
    }

    override fun onDestroy(owner: LifecycleOwner) {
        owner.lifecycle.removeObserver(this)
        if (disposed) {
            return
        }
        destroyMapViewIfNecessary()
    }

    override fun onRestoreInstanceState(bundle: Bundle?) {
        if (disposed) {
            return
        }
        mapView.onCreate(bundle)
    }

    override fun onSaveInstanceState(bundle: Bundle) {
        if (disposed) {
            return
        }
        mapView.onSaveInstanceState(bundle)
    }

    override fun dispose() {
        if (disposed) {
            return
        }
        disposed = true
        val lifecycle: Lifecycle? = lifecycleProvider.getLifecycle()
        lifecycle?.removeObserver(this)
    }

    private fun destroyMapViewIfNecessary() {
        mapView.onDestroy()
    }
}