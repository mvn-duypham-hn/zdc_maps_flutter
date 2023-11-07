package vn.duypx.zdc_maps_flutter_example

import android.widget.Toast
import com.zdc.android.zms.maps.ErrorCode
import com.zdc.android.zms.maps.MapInitializer
import io.flutter.app.FlutterApplication


class ApplicationEx : FlutterApplication() {

    // TODO update value here
    private val serverDomain = ""
    private val consumerKey = ""
    private val consumerSecret = ""

    override fun onCreate() {
        super.onCreate()

        val ret = MapInitializer.initialize(
            applicationContext,
            serverDomain,
            consumerKey,
            consumerSecret
        )
        if (ret != ErrorCode.ZDCMAP_OK) {
            Toast.makeText(this@ApplicationEx, "initialize error :$ret", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onTerminate() {
        super.onTerminate()
    }
}
