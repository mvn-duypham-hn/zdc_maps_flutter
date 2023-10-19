part of zdc_maps_flutter;

int _nextMapCreationId = 0;

class ZDCMap extends StatefulWidget {
  const ZDCMap({super.key});

  @override
  State createState() => _ZDCMapState();
}

class _ZDCMapState extends State<ZDCMap> {
  final int _mapId = _nextMapCreationId++;

  final bool useAndroidViewSurface = true;

  @override
  Widget build(BuildContext context) {
    const String viewType = 'vn.duypx/zdc_maps_view_type';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{
      // 'initialCameraPosition':
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if (useAndroidViewSurface) {
          return PlatformViewLink(
            surfaceFactory: (context, controller) {
              return AndroidViewSurface(
                controller: controller as AndroidViewController,
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                gestureRecognizers: const <Factory<
                    OneSequenceGestureRecognizer>>{},
              );
            },
            onCreatePlatformView: (params) {
              return PlatformViewsService.initSurfaceAndroidView(
                id: params.id,
                viewType: viewType,
                layoutDirection: TextDirection.ltr,
                creationParams: creationParams,
                creationParamsCodec: const StandardMessageCodec(),
                onFocus: () {
                  params.onFocusChanged(true);
                },
              )
                ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                ..create();
            },
            viewType: viewType,
          );
        }
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}
