package vn.duypx.zdc_maps_flutter

import androidx.annotation.Nullable
import androidx.lifecycle.Lifecycle

interface LifecycleProvider {
    @Nullable
    fun getLifecycle(): Lifecycle?
}