import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'zdc_maps_flutter_method_channel.dart';

abstract class ZdcMapsFlutterPlatform extends PlatformInterface {
  /// Constructs a ZdcMapsFlutterPlatform.
  ZdcMapsFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZdcMapsFlutterPlatform _instance = MethodChannelZdcMapsFlutter();

  /// The default instance of [ZdcMapsFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelZdcMapsFlutter].
  static ZdcMapsFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZdcMapsFlutterPlatform] when
  /// they register themselves.
  static set instance(ZdcMapsFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init(int mapId) {
    throw UnimplementedError('init() has not been implemented.');
  }

  void dispose({required int mapId}) {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  Widget buildView() {
    throw UnimplementedError('buildView() has not been implemented.');
  }
}
