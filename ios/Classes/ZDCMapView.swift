//
//  FLZDCMapView.swift
//  Runner
//
//  Created by Duy Pham X. VN.Hanoi on 15/10/2023.
//

import Flutter
import UIKit
import ZDCMaps
import Foundation

class ZDCMapView: NSObject, FlutterPlatformView, ZMSMapViewDelegate {
    private var _mapView: ZMSMapView
    private var _registrar: FlutterPluginRegistrar
    private var _channel: FlutterMethodChannel
    
    func view() -> UIView {
        return _mapView
    }
    
    init(frame: CGRect,
         viewIdentifier viewId: Int64,
         arguments args: Any?,
         registrar: FlutterPluginRegistrar
    ) {
        let camera = ZMSCameraPosition.camera(withLatitude: 35.6276017, longitude: 139.7409166, zoom: 13)
        _mapView = ZMSMapView.map(withFrame: frame, camera: camera)
        _mapView.accessibilityElementsHidden = false
        _registrar = registrar
        
        let channelName = "vn.duypx/zdc_maps_\(viewId)"
        _channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
        
        super.init()
        
        _mapView.delegate = self
        _mapView.mapType = _mapView.mapTypeList[0]
        
        _mapView.addObserver(self, forKeyPath: "frame", options: [], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (object as! NSObject == self._mapView && keyPath == "frame") {
            let bounds = self._mapView.bounds
            if (bounds.equalTo(CGRect.zero)) {
                return
            }
            self._mapView.removeObserver(self, forKeyPath: "frame")
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
    }
    
}
