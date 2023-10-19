import Flutter
import UIKit

public class ZdcMapsFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let zdcMapViewFactory = ZDCMapViewFactory(registrar: registrar)
        registrar.register(zdcMapViewFactory, withId: "vn.duypx/zdc_maps_view_type", gestureRecognizersBlockingPolicy: FlutterPlatformViewGestureRecognizersBlockingPolicyWaitUntilTouchesEnded)
    }
}
