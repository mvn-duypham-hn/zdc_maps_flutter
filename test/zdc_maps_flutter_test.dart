import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zdc_maps_flutter/zdc_maps_flutter.dart';
import 'package:zdc_maps_flutter/zdc_maps_flutter_platform_interface.dart';
import 'package:zdc_maps_flutter/zdc_maps_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZdcMapsFlutterPlatform
    with MockPlatformInterfaceMixin
    implements ZdcMapsFlutterPlatform {

  @override
  Widget buildView() {
    // TODO: implement buildView
    throw UnimplementedError();
  }

  @override
  Future<void> init(int mapId) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  void dispose({required int mapId}) {
    // TODO: implement dispose
  }
}

void main() {
  final ZdcMapsFlutterPlatform initialPlatform = ZdcMapsFlutterPlatform.instance;

  test('$MethodChannelZdcMapsFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZdcMapsFlutter>());
  });

}
