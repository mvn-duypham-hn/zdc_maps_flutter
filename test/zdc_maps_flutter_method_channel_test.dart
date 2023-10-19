import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zdc_maps_flutter/zdc_maps_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelZdcMapsFlutter platform = MethodChannelZdcMapsFlutter();
  const MethodChannel channel = MethodChannel('zdc_maps_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });
}
