//
//  ZDCMapViewFactory.swift
//  zdc_maps_flutter
//
//  Created by Duy Pham X. VN.Hanoi on 19/10/2023.
//
import Flutter
import UIKit

class ZDCMapViewFactory: NSObject, FlutterPlatformViewFactory {
    private var registrar: FlutterPluginRegistrar
    
    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return ZDCMapView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            registrar: registrar)
    }
    
    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
